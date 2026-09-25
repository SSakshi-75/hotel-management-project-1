using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

public partial class Booking : System.Web.UI.Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.HttpMethod == "POST" && Request["action"] == "create_booking")
        {
            CreateBookingEndpoint();
            return;
        }

        if (!IsPostBack)
        {
            LoadBookingRooms();
        }
    }

    private void LoadBookingRooms()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        RoomID,
                        RoomName,
                        PricePerNight,
                        MaxGuests,
                        RoomArea,
                        PrimaryRoomImage
                    FROM Rooms
                    WHERE ISNULL(IsActive, 1) = 1
                    ORDER BY RoomID ASC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        rptBookingRooms.DataSource = dt;
                        rptBookingRooms.DataBind();

                        rptBookingRoomSelectOptions.DataSource = dt;
                        rptBookingRoomSelectOptions.DataBind();
                    }
                }
            }
        }
        catch (Exception)
        {
        }
    }

    public string GetRoomImageUrl(object imgObj)
    {
        if (imgObj == null || string.IsNullOrWhiteSpace(imgObj.ToString()))
        {
            return ResolveUrl("~/images/room-mini-business.jpg");
        }
        string imgPath = imgObj.ToString().Trim();
        if (imgPath.StartsWith("http://") || imgPath.StartsWith("https://")) return imgPath;
        if (imgPath.StartsWith("~/")) return ResolveUrl(imgPath);
        if (imgPath.StartsWith("/")) return ResolveUrl("~" + imgPath);
        if (imgPath.StartsWith("images/")) return ResolveUrl("~/" + imgPath);
        return ResolveUrl("~/images/rooms/" + imgPath);
    }

    public string GetFormattedRoomArea(object areaObj)
    {
        if (areaObj == null || string.IsNullOrWhiteSpace(areaObj.ToString()))
        {
            return "400 sq ft";
        }
        string area = areaObj.ToString().Trim();
        if (area.ToLower().Contains("sq"))
        {
            return area;
        }
        return area + " sq ft";
    }

    public string GetFormattedPrice(object priceObj)
    {
        if (priceObj == null || priceObj == DBNull.Value) return "0";
        decimal p;
        if (decimal.TryParse(priceObj.ToString(), out p))
        {
            return p.ToString("N0");
        }
        return priceObj.ToString();
    }

    private void CreateBookingEndpoint()
    {
        Response.ContentType = "application/json";
        Response.Clear();

        try
        {
            string sRoomId = Request["roomId"];
            string roomName = Request["roomName"] ?? "";
            string sCheckIn = Request["checkIn"];
            string sCheckOut = Request["checkOut"];
            string sAdults = Request["adults"] ?? "1";
            string sChildren = Request["children"] ?? "0";
            string sRooms = Request["rooms"] ?? "1";
            string guestName = Request["guestName"] ?? "";
            string guestEmail = Request["guestEmail"] ?? "";
            string guestPhone = Request["guestPhone"] ?? "";
            string specialRequests = Request["specialRequests"] ?? "";
            string sRate = Request["ratePerNight"] ?? "0";
            string sTotal = Request["totalAmount"] ?? "0";

            // Validate guest details
            if (string.IsNullOrWhiteSpace(guestName) || string.IsNullOrWhiteSpace(guestEmail) || string.IsNullOrWhiteSpace(guestPhone))
            {
                SendJsonResponse(false, "Please provide complete guest contact details (Name, Email, Phone).", "");
                return;
            }

            DateTime checkIn;
            DateTime checkOut;
            if (!DateTime.TryParse(sCheckIn, out checkIn) || !DateTime.TryParse(sCheckOut, out checkOut))
            {
                SendJsonResponse(false, "Invalid check-in or check-out date.", "");
                return;
            }

            if (checkIn.Date < DateTime.Today)
            {
                SendJsonResponse(false, "Check-in date cannot be in the past.", "");
                return;
            }

            if (checkOut.Date <= checkIn.Date)
            {
                SendJsonResponse(false, "Check-out date must be after check-in date.", "");
                return;
            }

            int adults;
            int.TryParse(sAdults, out adults);
            if (adults < 1) adults = 1;

            int children;
            int.TryParse(sChildren, out children);

            int totalRoomsCount;
            int.TryParse(sRooms, out totalRoomsCount);
            if (totalRoomsCount < 1) totalRoomsCount = 1;

            decimal ratePerNight;
            decimal.TryParse(sRate, out ratePerNight);

            decimal totalAmount;
            decimal.TryParse(sTotal, out totalAmount);

            int nights = (int)(checkOut.Date - checkIn.Date).TotalDays;
            if (nights <= 0) nights = 1;

            if (totalAmount <= 0 && ratePerNight > 0)
            {
                decimal baseCost = ratePerNight * nights * totalRoomsCount;
                decimal taxes = Math.Round(baseCost * 0.18m, 2);
                totalAmount = baseCost + taxes;
            }

            int roomId;
            int.TryParse(sRoomId, out roomId);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Serializable transaction to eliminate race conditions & double booking
                using (SqlTransaction tran = con.BeginTransaction(IsolationLevel.Serializable))
                {
                    try
                    {
                        // Resolve RoomID if not provided
                        if (roomId <= 0 && !string.IsNullOrWhiteSpace(roomName))
                        {
                            string resolveRoomSql = "SELECT TOP 1 RoomID FROM Rooms WHERE RoomName = @RName";
                            using (SqlCommand resCmd = new SqlCommand(resolveRoomSql, con, tran))
                            {
                                resCmd.Parameters.AddWithValue("@RName", roomName.Trim());
                                object objId = resCmd.ExecuteScalar();
                                if (objId != null && objId != DBNull.Value)
                                {
                                    roomId = Convert.ToInt32(objId);
                                }
                            }
                        }

                        if (roomId <= 0)
                        {
                            string fallbackSql = "SELECT TOP 1 RoomID FROM Rooms WHERE ISNULL(IsActive, 1) = 1 ORDER BY RoomID";
                            using (SqlCommand fbCmd = new SqlCommand(fallbackSql, con, tran))
                            {
                                object objId = fbCmd.ExecuteScalar();
                                if (objId != null && objId != DBNull.Value)
                                {
                                    roomId = Convert.ToInt32(objId);
                                }
                            }
                        }

                        if (roomId <= 0)
                        {
                            tran.Rollback();
                            SendJsonResponse(false, "Selected room could not be found in hotel records.", "");
                            return;
                        }

                        // 1. Check room master status with UPDLOCK, HOLDLOCK
                        string lockRoomSql = @"
                            SELECT RoomID, RoomName, RoomStatus, IsActive, MaxGuests, PricePerNight
                            FROM Rooms WITH (UPDLOCK, HOLDLOCK)
                            WHERE RoomID = @RoomId";

                        string actualRoomName = roomName;
                        using (SqlCommand roomCmd = new SqlCommand(lockRoomSql, con, tran))
                        {
                            roomCmd.Parameters.AddWithValue("@RoomId", roomId);
                            using (SqlDataReader rdr = roomCmd.ExecuteReader())
                            {
                                if (!rdr.Read())
                                {
                                    rdr.Close();
                                    tran.Rollback();
                                    SendJsonResponse(false, "Selected room does not exist.", "");
                                    return;
                                }

                                bool isActive = rdr["IsActive"] != DBNull.Value ? Convert.ToBoolean(rdr["IsActive"]) : true;
                                string roomStatus = rdr["RoomStatus"] != DBNull.Value ? rdr["RoomStatus"].ToString() : "Available";
                                actualRoomName = rdr["RoomName"].ToString();

                                if (!isActive)
                                {
                                    rdr.Close();
                                    tran.Rollback();
                                    SendJsonResponse(false, "Selected room is currently deactivated.", "");
                                    return;
                                }

                                if (roomStatus.Equals("Maintenance", StringComparison.OrdinalIgnoreCase) ||
                                    roomStatus.Equals("Blocked", StringComparison.OrdinalIgnoreCase) ||
                                    roomStatus.Equals("Inactive", StringComparison.OrdinalIgnoreCase))
                                {
                                    rdr.Close();
                                    tran.Rollback();
                                    SendJsonResponse(false, "This room is currently under " + roomStatus + " and cannot be reserved.", "");
                                    return;
                                }

                                rdr.Close();
                            }
                        }

                        // 2. Check for overlapping active bookings with UPDLOCK, HOLDLOCK
                        string overlapSql = @"
                            SELECT COUNT(*)
                            FROM Bookings WITH (UPDLOCK, HOLDLOCK)
                            WHERE RoomId = @RoomId
                              AND BookingStatus IN ('Pending', 'Confirmed', 'Checked-In')
                              AND CheckInDate < @CheckOutDate
                              AND CheckOutDate > @CheckInDate";

                        using (SqlCommand ovCmd = new SqlCommand(overlapSql, con, tran))
                        {
                            ovCmd.Parameters.AddWithValue("@RoomId", roomId);
                            ovCmd.Parameters.AddWithValue("@CheckInDate", checkIn.Date);
                            ovCmd.Parameters.AddWithValue("@CheckOutDate", checkOut.Date);

                            int overlapCount = Convert.ToInt32(ovCmd.ExecuteScalar());
                            if (overlapCount > 0)
                            {
                                tran.Rollback();
                                SendJsonResponse(false, "Double Booking Prevented: Room '" + actualRoomName + "' is already reserved for the selected dates (" + checkIn.ToString("dd MMM") + " – " + checkOut.ToString("dd MMM yyyy") + "). Please select different dates or choose another room.", "");
                                return;
                            }
                        }

                        // 3. Generate unique Booking Reference
                        string bookingRef = "HM-RES-" + DateTime.Now.ToString("yyMMdd") + new Random().Next(1000, 9999).ToString();

                        object userId = DBNull.Value;
                        if (Session["UserId"] != null)
                        {
                            int uid;
                            if (int.TryParse(Session["UserId"].ToString(), out uid))
                            {
                                userId = uid;
                            }
                        }

                        // 4. Insert booking record
                        string insertSql = @"
                            INSERT INTO Bookings (
                                BookingReference, UserId, GuestName, GuestEmail, GuestPhone,
                                RoomId, CheckInDate, CheckOutDate, Adults, Children, TotalRooms,
                                RatePerNight, TotalAmount, BookingStatus, SpecialRequests,
                                BookingDate, CreatedAt
                            ) VALUES (
                                @BookingReference, @UserId, @GuestName, @GuestEmail, @GuestPhone,
                                @RoomId, @CheckInDate, @CheckOutDate, @Adults, @Children, @TotalRooms,
                                @RatePerNight, @TotalAmount, 'Confirmed', @SpecialRequests,
                                GETDATE(), GETDATE()
                            )";

                        using (SqlCommand insCmd = new SqlCommand(insertSql, con, tran))
                        {
                            insCmd.Parameters.AddWithValue("@BookingReference", bookingRef);
                            insCmd.Parameters.AddWithValue("@UserId", userId);
                            insCmd.Parameters.AddWithValue("@GuestName", guestName.Trim());
                            insCmd.Parameters.AddWithValue("@GuestEmail", guestEmail.Trim());
                            insCmd.Parameters.AddWithValue("@GuestPhone", guestPhone.Trim());
                            insCmd.Parameters.AddWithValue("@RoomId", roomId);
                            insCmd.Parameters.AddWithValue("@CheckInDate", checkIn.Date);
                            insCmd.Parameters.AddWithValue("@CheckOutDate", checkOut.Date);
                            insCmd.Parameters.AddWithValue("@Adults", adults);
                            insCmd.Parameters.AddWithValue("@Children", children);
                            insCmd.Parameters.AddWithValue("@TotalRooms", totalRoomsCount);
                            insCmd.Parameters.AddWithValue("@RatePerNight", ratePerNight);
                            insCmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                            insCmd.Parameters.AddWithValue("@SpecialRequests", (object)specialRequests ?? DBNull.Value);

                            insCmd.ExecuteNonQuery();
                        }

                        tran.Commit();

                        SendJsonResponse(true, "Reservation successfully confirmed!", bookingRef);
                    }
                    catch (Exception exInner)
                    {
                        try { tran.Rollback(); } catch { }
                        SendJsonResponse(false, "Booking error: " + exInner.Message, "");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            SendJsonResponse(false, "System error: " + ex.Message, "");
        }
    }

    private void SendJsonResponse(bool success, string message, string reference)
    {
        string json = string.Format(
            "{{\"success\":{0},\"message\":\"{1}\",\"reference\":\"{2}\"}}",
            success ? "true" : "false",
            HttpUtility.JavaScriptStringEncode(message),
            HttpUtility.JavaScriptStringEncode(reference ?? "")
        );

        Response.Write(json);
        Response.End();
    }
}
