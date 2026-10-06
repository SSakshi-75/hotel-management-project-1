using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_RestaurantTables : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            EnsureTableExists();
            LoadTables();
        }
    }

    // ==========================================
    // ENSURE DATABASE TABLE AND SEED DATA
    // ==========================================
    private void EnsureTableExists()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string script = @"
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='RestaurantTables' AND xtype='U')
                    BEGIN
                        CREATE TABLE RestaurantTables (
                            TableId INT IDENTITY(1,1) PRIMARY KEY,
                            TableNumber NVARCHAR(50) NOT NULL UNIQUE,
                            TableName NVARCHAR(100) NOT NULL,
                            Capacity INT NOT NULL DEFAULT 2,
                            Section NVARCHAR(100) NULL,
                            Location NVARCHAR(100) NULL,
                            Floor NVARCHAR(50) NULL DEFAULT 'Ground Floor',
                            TableStatus NVARCHAR(50) NOT NULL DEFAULT 'Available',
                            IsActive BIT NOT NULL DEFAULT 1,
                            CreatedDate DATETIME DEFAULT GETDATE()
                        );
                    END;";

                using (SqlCommand cmd = new SqlCommand(script, con))
                {
                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            // Non-blocking fallback
        }
    }

    // ==========================================
    // LOAD TABLES INTO REPEATER AND KPI CARDS
    // ==========================================
    private void LoadTables()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("TableId", typeof(int));
        dt.Columns.Add("TableNumber", typeof(string));
        dt.Columns.Add("TableName", typeof(string));
        dt.Columns.Add("Capacity", typeof(int));
        dt.Columns.Add("Location", typeof(string));
        dt.Columns.Add("Section", typeof(string));
        dt.Columns.Add("Floor", typeof(string));
        dt.Columns.Add("TableStatus", typeof(string));
        dt.Columns.Add("IsActive", typeof(bool));

        int totalCount = 0;
        int availableCount = 0;
        int reservedCount = 0;
        int blockedCount = 0;

        if (!string.IsNullOrEmpty(connectionString))
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = @"
                        SELECT TableId, TableNumber, TableName, Capacity, Location, Section, Floor, TableStatus, IsActive
                        FROM RestaurantTables
                        ORDER BY TableNumber ASC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                int tableId = Convert.ToInt32(dr["TableId"]);
                                string tableNum = dr["TableNumber"] != DBNull.Value ? dr["TableNumber"].ToString() : "";
                                string tableName = dr["TableName"] != DBNull.Value ? dr["TableName"].ToString() : "";
                                int capacity = dr["Capacity"] != DBNull.Value ? Convert.ToInt32(dr["Capacity"]) : 2;
                                string location = dr["Location"] != DBNull.Value ? dr["Location"].ToString() : "";
                                string section = dr["Section"] != DBNull.Value ? dr["Section"].ToString() : "";
                                string floor = dr["Floor"] != DBNull.Value ? dr["Floor"].ToString() : "Ground Floor";
                                string status = dr["TableStatus"] != DBNull.Value ? dr["TableStatus"].ToString() : "Available";
                                bool isActive = dr["IsActive"] != DBNull.Value ? Convert.ToBoolean(dr["IsActive"]) : true;

                                dt.Rows.Add(tableId, tableNum, tableName, capacity, location, section, floor, status, isActive);

                                totalCount++;
                                if (string.Equals(status, "Available", StringComparison.OrdinalIgnoreCase)) availableCount++;
                                else if (string.Equals(status, "Booked", StringComparison.OrdinalIgnoreCase) || string.Equals(status, "Reserved", StringComparison.OrdinalIgnoreCase)) reservedCount++;
                                else if (string.Equals(status, "Blocked", StringComparison.OrdinalIgnoreCase)) blockedCount++;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Non-blocking fallback
            }
        }

        lblTotalTables.Text = totalCount + (totalCount == 1 ? " Table" : " Tables");
        lblAvailableTables.Text = availableCount + (availableCount == 1 ? " Table" : " Tables");
        lblReservedTables.Text = reservedCount + (reservedCount == 1 ? " Table" : " Tables");
        lblBlockedTables.Text = blockedCount + (blockedCount == 1 ? " Table" : " Tables");

        trNoTables.Visible = (dt.Rows.Count == 0);

        rptTables.DataSource = dt;
        rptTables.DataBind();
    }

    // ==========================================
    // STATUS BADGE RENDERER HELPER FOR ASPX
    // ==========================================
    public string GetStatusBadge(string status)
    {
        if (string.Equals(status, "Available", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-badge-available\"><i class=\"bi bi-circle-fill\" style=\"font-size: 0.55rem;\"></i> Available</span>";
        }
        else if (string.Equals(status, "Booked", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-badge-booked\"><i class=\"bi bi-x-circle-fill text-danger\" style=\"font-size: 0.75rem;\"></i> Booked</span>";
        }
        else if (string.Equals(status, "Reserved", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-badge-reserved\"><i class=\"bi bi-circle-fill\" style=\"font-size: 0.55rem;\"></i> Reserved</span>";
        }
        else if (string.Equals(status, "Blocked", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-badge-blocked\"><i class=\"bi bi-circle-fill\" style=\"font-size: 0.55rem;\"></i> Blocked</span>";
        }
        return "<span class=\"badge bg-secondary\">" + HttpUtility.HtmlEncode(status) + "</span>";
    }

    // ==========================================
    // SAVE / UPDATE TABLE HANDLER
    // ==========================================
    protected void btnSaveTable_Click(object sender, EventArgs e)
    {
        string tableNum = txtTableNumber.Text.Trim();
        string tableName = txtTableName.Text.Trim();
        string section = txtSection.Text.Trim();
        string location = txtLocation.Text.Trim();
        string floor = ddlFloor.SelectedValue;
        string status = ddlTableStatus.SelectedValue;
        bool isActive = ddlIsActive.SelectedValue == "1";

        int capacity = 2;
        if (!int.TryParse(txtCapacity.Text.Trim(), out capacity) || capacity <= 0)
        {
            capacity = 2;
        }

        if (string.IsNullOrEmpty(tableNum))
        {
            pnlStatusMsg.Visible = true;
            lblStatusMessage.Text = "Please enter a Table Number (e.g. T-01).";
            return;
        }

        if (string.IsNullOrEmpty(tableName))
        {
            tableName = "Table " + tableNum;
        }

        int editId = 0;
        int.TryParse(hfEditTableId.Value, out editId);

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                if (editId > 0)
                {
                    // UPDATE TABLE
                    string updateQuery = @"
                        UPDATE RestaurantTables
                        SET TableNumber = @TableNumber,
                            TableName = @TableName,
                            Capacity = @Capacity,
                            Section = @Section,
                            Location = @Location,
                            Floor = @Floor,
                            TableStatus = @TableStatus,
                            IsActive = @IsActive
                        WHERE TableId = @TableId";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@TableId", editId);
                        cmd.Parameters.AddWithValue("@TableNumber", tableNum);
                        cmd.Parameters.AddWithValue("@TableName", tableName);
                        cmd.Parameters.AddWithValue("@Capacity", capacity);
                        cmd.Parameters.AddWithValue("@Section", string.IsNullOrEmpty(section) ? "Main Dining" : section);
                        cmd.Parameters.AddWithValue("@Location", string.IsNullOrEmpty(location) ? "Main Hall" : location);
                        cmd.Parameters.AddWithValue("@Floor", floor);
                        cmd.Parameters.AddWithValue("@TableStatus", status);
                        cmd.Parameters.AddWithValue("@IsActive", isActive);
                        cmd.ExecuteNonQuery();
                    }

                    pnlStatusMsg.Visible = true;
                    lblStatusMessage.Text = "Updated successfully";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "TableUpdated",
                        "showConfirmation('Updated successfully');",
                        true
                    );
                }
                else
                {
                    // INSERT TABLE (UPSERT IF ALREADY EXISTS)
                    string insertQuery = @"
                        IF EXISTS (SELECT 1 FROM RestaurantTables WHERE TableNumber = @TableNumber)
                        BEGIN
                            UPDATE RestaurantTables
                            SET TableName = @TableName,
                                Capacity = @Capacity,
                                Section = @Section,
                                Location = @Location,
                                Floor = @Floor,
                                TableStatus = @TableStatus,
                                IsActive = @IsActive
                            WHERE TableNumber = @TableNumber
                        END
                        ELSE
                        BEGIN
                            INSERT INTO RestaurantTables (TableNumber, TableName, Capacity, Location, Section, Floor, TableStatus, IsActive)
                            VALUES (@TableNumber, @TableName, @Capacity, @Location, @Section, @Floor, @TableStatus, @IsActive)
                        END";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@TableNumber", tableNum);
                        cmd.Parameters.AddWithValue("@TableName", tableName);
                        cmd.Parameters.AddWithValue("@Capacity", capacity);
                        cmd.Parameters.AddWithValue("@Section", string.IsNullOrEmpty(section) ? "Main Dining" : section);
                        cmd.Parameters.AddWithValue("@Location", string.IsNullOrEmpty(location) ? "Main Hall" : location);
                        cmd.Parameters.AddWithValue("@Floor", floor);
                        cmd.Parameters.AddWithValue("@TableStatus", status);
                        cmd.Parameters.AddWithValue("@IsActive", isActive);
                        cmd.ExecuteNonQuery();
                    }

                    pnlStatusMsg.Visible = true;
                    lblStatusMessage.Text = "Updated successfully";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "TableAdded",
                        "showConfirmation('Updated successfully');",
                        true
                    );
                }
            }
        }
        catch (Exception ex)
        {
            pnlStatusMsg.Visible = true;
            lblStatusMessage.Text = "Error saving table: " + ex.Message;
        }

        ResetForm();
        LoadTables();
    }

    // ==========================================
    // REPEATER COMMAND (EDIT & DELETE)
    // ==========================================
    protected void rptTables_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int tableId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "EditTable")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = @"
                        SELECT TableId, TableNumber, TableName, Capacity, Section, Location, Floor, TableStatus, IsActive
                        FROM RestaurantTables
                        WHERE TableId = @TableId";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@TableId", tableId);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                hfEditTableId.Value = dr["TableId"].ToString();
                                txtTableNumber.Text = dr["TableNumber"].ToString();
                                txtTableName.Text = dr["TableName"].ToString();
                                txtCapacity.Text = dr["Capacity"].ToString();
                                txtSection.Text = dr["Section"] != DBNull.Value ? dr["Section"].ToString() : "";
                                txtLocation.Text = dr["Location"] != DBNull.Value ? dr["Location"].ToString() : "";

                                string fl = dr["Floor"] != DBNull.Value ? dr["Floor"].ToString() : "Ground Floor";
                                if (ddlFloor.Items.FindByValue(fl) != null) ddlFloor.SelectedValue = fl;

                                string st = dr["TableStatus"] != DBNull.Value ? dr["TableStatus"].ToString() : "Available";
                                if (ddlTableStatus.Items.FindByValue(st) != null) ddlTableStatus.SelectedValue = st;

                                bool act = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
                                ddlIsActive.SelectedValue = act ? "1" : "0";

                                litFormTitle.Text = "Edit Table (" + dr["TableNumber"].ToString() + ")";
                                btnSaveTable.Text = "Update Table";
                                btnCancelEdit.Visible = true;

                                txtTableNumber.Focus();

                                pnlStatusMsg.Visible = true;
                                lblStatusMessage.Text = "Table " + dr["TableNumber"].ToString() + " loaded for editing.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlStatusMsg.Visible = true;
                lblStatusMessage.Text = "Error loading table details: " + ex.Message;
            }
        }
        else if (e.CommandName == "DeleteTable")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = "DELETE FROM RestaurantTables WHERE TableId = @TableId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@TableId", tableId);
                        cmd.ExecuteNonQuery();
                    }
                }

                pnlStatusMsg.Visible = true;
                lblStatusMessage.Text = "Updated successfully";

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "TableDeleted",
                    "showConfirmation('Updated successfully');",
                    true
                );

                ResetForm();
                LoadTables();
            }
            catch (Exception ex)
            {
                pnlStatusMsg.Visible = true;
                lblStatusMessage.Text = "Error deleting table: " + ex.Message;
            }
        }
    }

    // ==========================================
    // CANCEL EDIT
    // ==========================================
    protected void btnCancelEdit_Click(object sender, EventArgs e)
    {
        ResetForm();
    }

    private void ResetForm()
    {
        hfEditTableId.Value = "0";
        txtTableNumber.Text = "";
        txtTableName.Text = "";
        txtCapacity.Text = "2";
        txtSection.Text = "";
        txtLocation.Text = "";
        ddlFloor.SelectedIndex = 0;
        ddlTableStatus.SelectedIndex = 0;
        ddlIsActive.SelectedIndex = 0;

        litFormTitle.Text = "1. Add New Table";
        btnSaveTable.Text = "+ Add Table";
        btnCancelEdit.Visible = false;
    }
}
