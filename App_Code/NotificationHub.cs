using Microsoft.AspNet.SignalR;

public class NotificationHub : Hub
{
    public void SendNotification(string message)
    {
        Clients.All.receiveNotification(message);
    }
}