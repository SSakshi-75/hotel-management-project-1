using System;
using Microsoft.AspNet.SignalR;

public class NotificationHub : Hub
{
    public void SendNotification(string message)
    {
        Clients.All.receiveNotification(message);
    }

    public static void Broadcast(string message)
    {
        try
        {
            var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            if (hubContext != null)
            {
                hubContext.Clients.All.receiveNotification(message);
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("SignalR Broadcast error: " + ex.Message);
        }
    }
}