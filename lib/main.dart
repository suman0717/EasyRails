import 'dart:convert';
import 'dart:async';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/notification.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'myapp.dart';

//this is the name given to the background fetch
const simplePeriodicTask = "simplePeriodicTask";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher,
      isInDebugMode: false); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager.registerPeriodicTask("5",
      simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(minutes: 15),
      //when should it check the link
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        accentColor: Colors.white,
        primaryColor: kShadeColor1,),
      title: 'EasyRails',
      home: MyApp(),
    ),
  );
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);
    http.Response response = await http.get(kGetNotification);
    var responsebody=response.body;
    var decodedJson=jsonDecode(responsebody)['response'];
    if(decodedJson == null) {
      decodedJson=jsonDecode(responsebody);
      var _notificationid = decodedJson['UniqueId'];
      var _notificationbody = decodedJson['Body'];
      var _notificationTitle = decodedJson['Title'];
      // notificationPlugin.showNotificationWithAttachment(1,_notificationbody,_notificationTitle);
      notificationPlugin.showNotification(1,_notificationbody,_notificationTitle);
    }
    else{
      List notificationList=decodedJson;
      for(int i=0;i<notificationList.length;i++){
        var _notificationid = decodedJson[i]['UniqueId'];
        var _notificationbody = decodedJson[i]['Body'];
        var _notificationTitle = decodedJson[i]['Title'];
        // await notificationPlugin.showNotificationWithAttachment(i,_notificationbody,_notificationTitle);
        await notificationPlugin.showNotification(i,_notificationbody,_notificationTitle);
      }
    }
    return Future.value(true);
  });
}
