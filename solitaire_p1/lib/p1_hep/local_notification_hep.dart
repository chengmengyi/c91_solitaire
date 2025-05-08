import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';

class LocalNotificationHep{
  static final LocalNotificationHep _instance = LocalNotificationHep();
  static LocalNotificationHep get instance => _instance;

  var flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  setLocalNotifications()async{
    var success = await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _clickLocalNotification(notificationResponse.id);
            break;
          case NotificationResponseType.selectedNotificationAction:
            _clickLocalNotification(notificationResponse.id);
            break;
        }
      },
    );
    if(success==true){
      _showNotification(
        id: 1,
        title: "Opportunity Arrived!",
        content: "Opportunity has arrived! ",
        duration: const Duration(minutes: 30),
      );
      _showNotification(
        id: 2,
        title: "Special Gift Awaiting!",
        content: "Special gift waiting! Tap to reveal!",
        duration: const Duration(minutes: 60),
      );
      _showNotification(
        id: 3,
        title: "Win Instant Cash Now!",
        content: "Lucky Spin Available! Win Instant Cash!",
        duration: const Duration(minutes: 90),
      );
      _showNotification(
        id: 4,
        title: "Top Gamers Cash Out!",
        content: "Top Gamers Earn Huge! Instant Cash Rewards!",
        duration: const Duration(minutes: 300),
      );
    }else{
      // _checkPermission();
    }
  }

  _showNotification({
    required int id,
    required String title,
    required String content,
    required Duration duration,
}){
    flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
      id,
      title,
      content,
      duration,
      const NotificationDetails(),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  checkFromIcon()async{
    var launchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if(launchDetails?.didNotificationLaunchApp==true){
      _clickLocalNotification(launchDetails?.notificationResponse?.id);
    }
  }

  _clickLocalNotification(int? id){
    PointHep.instance.point(pointEvent: PointEvent.all_push_c,params: {"push_type":id??0});
  }
}