class Notifications {
  static final List<NotificationData> list = [
    NotificationData(
        content: "test test test test test test test",
        notificationType: 0,
        date: DateTime.now()),
    NotificationData(
        content: "test test test test test test test",
        notificationType: 1,
        date: DateTime.now()),
    NotificationData(
        content: "test test test test test test test",
        notificationType: 2,
        date: DateTime.now())
  ];
}

class NotificationData {
  final String content;
  final DateTime date;
  final int notificationType;

  const NotificationData(
      {required this.content,
      required this.notificationType,
      required this.date});

  String getContent() {
    return content;
  }

  int getNotifictionType() {
    return notificationType;
  }

  DateTime getDate() {
    return date;
  }
}
