import UserNotifications

struct NotificationManager {
    func notification(name: String, id: String, date: Date, hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.body = "Today is a birthday - \(name)"
        content.sound = .defaultRingtone
        content.title = "Happy birthday to your friend"

        var dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )
        let center = UNUserNotificationCenter.current()
        center.add(request)
       // center.removeDeliveredNotifications(withIdentifiers: <#T##[String]#>)
    }
}
