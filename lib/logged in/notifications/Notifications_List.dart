import 'package:flutter/material.dart';
import 'package:test_app/logged in/notifications/Notification_Data.dart';
import 'package:intl/intl.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});
  @override
  State<NotificationsList> createState() {
    return _NotificationsListState();
  }
}

class _NotificationsListState extends State<NotificationsList> {
  List<NotificationData> list = []; //Notifications.list;

  void _removeNotification(String removedNotification) {
    setState(() {
      //remove the notification from list
    });
    final String _removedNotification = removedNotification;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      content: const Text("Notification is removed"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              //bring the notification back to the list
            });
          }),
    ));
  }

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
              key: ValueKey(list[index]),
              background: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal:
                          Theme.of(context).cardTheme.margin!.horizontal),
                  child: Text("Delete",
                      style: Theme.of(context).textTheme.bodyMedium)),
              onDismissed: null,
              child: NotificationCard(data: list[index]));
        });
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationData data;
  const NotificationCard({required this.data, super.key});

  @override
  Widget build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              child: Icon(Icons.abc_rounded, size: screenWidth * 0.08)),
          Column(
            children: [
              Text(data.getContent(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87)),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  width: double.infinity,
                  child: Text(
                      DateFormat.yMMM().format(data.getDate()).toString(),
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black45)))
            ],
          )
        ]),
      ),
    );
  }
}
