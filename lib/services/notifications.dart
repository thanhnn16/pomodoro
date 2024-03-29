import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Learning source: https://pub.dev/packages/flutter_local_notifications

class Notifications {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Notifications() {
    // _initializeNotifications();
  }

  // void _initializeNotifications() {
  //   // TODO: Initialize FlutterLocalNotificationsPlugin
  //   var androidInitializationSettings =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var iOSInitializationSettings = IOSInitializationSettings();
  //   var webInitializationSettings = WebInitializationSettings();
  //   var initializationSettings = InitializationSettings(
  //       android: androidInitializationSettings,
  //       iOS: iOSInitializationSettings,
  //       web: webInitializationSettings
  //   );
  //
  //   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   _flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: selectNotification);
  // }

  void showNotification(String title, String body) {
    // TODO: Implement the logic to show a local notification
  }
}
