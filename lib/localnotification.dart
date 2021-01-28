// import 'package:easy_rails/notification.dart';
// import 'package:flutter/material.dart';
//
// class LocalNotificationScreen extends StatefulWidget {
//   @override
//   _LocalNotificationScreenState createState() => _LocalNotificationScreenState();
// }
//
// class _LocalNotificationScreenState extends State<LocalNotificationScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     notificationPlugin.setListenerForLowerVersions(onNotificationOnLowerVersions);
//     notificationPlugin.setOnNotificationClick(onNotificationClick);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FlatButton(child: Text('Send Notification'),
//           onPressed: () async {
//           await notificationPlugin.showNotification();
//             print('Send Notificaiton tapped');
//           },
//         ),
//       ),
//     );
//   }
//   onNotificationOnLowerVersions(ReceivedNotification receivedNotification){
//
//   }
//   onNotificationClick(String payload){
//
//   }
// }

import 'package:easy_rails/notification.dart';
import 'package:easy_rails/notificationScreen.dart';
import 'package:flutter/material.dart';

class LocalNotificationScreen extends StatefulWidget {
  @override
  _LocalNotificationScreenState createState() =>
      _LocalNotificationScreenState();
}

class _LocalNotificationScreenState extends State<LocalNotificationScreen> {
  //

  int count = 0;

  @override
  void initState() {
    super.initState();
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Local Notifications'),
      // ),
      body: Center(
        child: FlatButton(
          onPressed: () async {
            // notificationPlugin.showNotification('title SUman','Body SUman');
            // await notificationPlugin.scheduleNotification();
            await notificationPlugin.showNotificationWithAttachment(7,'body','title');
            // await notificationPlugin.repeatNotification();
            // await notificationPlugin.showDailyAtTime();
            // await notificationPlugin.showWeeklyAtDayTime();
            // count = await notificationPlugin.getPendingNotificationCount();
            // print('Count $count');
            // await notificationPlugin.cancelNotification();
            // count = await notificationPlugin.getPendingNotificationCount();
            // print('Count $count');
          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
    Navigator.push(context, MaterialPageRoute(builder: (coontext) {
      return NotificationScreen(
        payload: payload,
      );
    }));
  }
}