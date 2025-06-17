import 'package:flutter_android_local_notification/flutter_android_local_notification.dart';
import 'package:flutter_android_local_notification/local_notification_callback.dart';
import 'package:flutter_android_local_notification/local_notification_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';

class NotificationType{
  static const String type1="type1";
  static const String type2="type2";
  static const String type3="type3";
  static const String type4="type4";
  static const String type5="type5";
  static const String type6="type6";
  static const String type7="type7";
  static const String type8="type8";
  static const String type9="type9";
  static const String type10="type10";
}

class LocalNotificationHep{
  static final LocalNotificationHep _instance = LocalNotificationHep();
  static LocalNotificationHep get instance => _instance;

  // var flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  setLocalNotifications()async{
    List<LocalNotificationConfig> workList=[];
    workList.add(LocalNotificationConfig(
      type: NotificationType.type1,
      title: "Grand Prize Arrives",
      body: "A new round of massive prizes is ready—unveil your moment of luck now!",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type2,
      title: "Fortune Winner: Claim Your Crown!",
      body: "Claim your cash now—and unlock massive rewards next!",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type3,
      title: "Opportunity Arrived!",
      body: "Opportunity has arrived! Claim your reward！",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type4,
      title: "Special Gift Awaiting!",
      body: "Special gift waiting! Tap to reveal!",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type5,
      title: "Win Instant Cash Now!",
      body: "Lucky Spin Available! Win Instant Cash!",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type6,
      title: "Top Gamers Cash Out!",
      body: "Top Gamers Earn Huge! Instant Cash Rewards!",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type7,
      title: "Scratch Rankings—Aim for the Top!",
      body: "Live rankings updated—next champion could be you!",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type8,
      title: "Instant Win Available!",
      body: "Play a game and win 50 coins instantly! Your next move could be a winner.",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type9,
      title: "Tripeak Streak—Keep Winning!",
      body: "Your 3 - day win streak earns a lucky spin! Break the peaks for instant rewards now.",
      loopNum: 48,
      singleAddMinute: 60,
    ));
    workList.add(LocalNotificationConfig(
      type: NotificationType.type10,
      title: "Today’s Free Coins!",
      body: "Log in today to get 80 free coins. Simple as that—start playing!",
      loopNum: 48,
      singleAddMinute: 60,
    ));

    FlutterAndroidLocalNotification.instance.initAllNotification(
      fcmTopic: "luckyscratchfun_tips",
      workList: workList,
      lockScreenNotification: null,
      serviceNotification: null,
      callback: LocalNotificationCallback(
        clickNotificationCallback: (type){
          _clickLocalNotification(type);
        },
        lockScreenNotificationShow: (){},
      ),
    );

    // var success = await flutterLocalNotificationsPlugin.initialize(
    //   const InitializationSettings(
    //     iOS: DarwinInitializationSettings(
    //       requestAlertPermission: true,
    //       requestBadgePermission: true,
    //       requestSoundPermission: true,
    //     ),
    //   ),
    //   onDidReceiveNotificationResponse: (
    //       NotificationResponse notificationResponse) {
    //     switch (notificationResponse.notificationResponseType) {
    //       case NotificationResponseType.selectedNotification:
    //         _clickLocalNotification(notificationResponse.id);
    //         break;
    //       case NotificationResponseType.selectedNotificationAction:
    //         _clickLocalNotification(notificationResponse.id);
    //         break;
    //     }
    //   },
    // );
    // if(success==true){
    //   _showNotification(
    //     id: 1,
    //     title: "Opportunity Arrived!",
    //     content: "Opportunity has arrived! ",
    //     duration: const Duration(minutes: 30),
    //   );
    //   _showNotification(
    //     id: 2,
    //     title: "Special Gift Awaiting!",
    //     content: "Special gift waiting! Tap to reveal!",
    //     duration: const Duration(minutes: 60),
    //   );
    //   _showNotification(
    //     id: 3,
    //     title: "Win Instant Cash Now!",
    //     content: "Lucky Spin Available! Win Instant Cash!",
    //     duration: const Duration(minutes: 90),
    //   );
    //   _showNotification(
    //     id: 4,
    //     title: "Top Gamers Cash Out!",
    //     content: "Top Gamers Earn Huge! Instant Cash Rewards!",
    //     duration: const Duration(minutes: 300),
    //   );
    // }else{
    //   // _checkPermission();
    // }
  }

//   _showNotification({
//     required int id,
//     required String title,
//     required String content,
//     required Duration duration,
// }){
//     flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
//       id,
//       title,
//       content,
//       duration,
//       const NotificationDetails(),
//       androidScheduleMode: AndroidScheduleMode.alarmClock,
//     );
//   }

  checkFromIcon()async{
    var type = await FlutterAndroidLocalNotification.instance.getLaunchNotificationType();
    if(type.isNotEmpty){
      _clickLocalNotification(type);
    }
  }

  _clickLocalNotification(String type){
    PointHep.instance.point(pointEvent: PointEvent.all_push_c,params: {"push_type":type});
  }
}