import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:solitaire_p1/p1_hep/notification/local_notification_bean.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';

class NotificationId{
  static const int id1=1;
  static const int id2=2;
  static const int id3=3;
  static const int id4=4;
  static const int id5=5;
  static const int id6=6;
  static const int id7=7;
  static const int id8=8;
  static const int id9=9;
  static const int id10=10;
}

class LocalNotificationHep{
  static final LocalNotificationHep _instance = LocalNotificationHep();
  static LocalNotificationHep get instance => _instance;

  var flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  final List<LocalNotificationBean> _notificationList1_5=[
    LocalNotificationBean(notificationId: NotificationId.id1, title: "Grand Prize Arrives", desc: "Fortune Winner: Claim Your Crown!",),
    LocalNotificationBean(notificationId: NotificationId.id1, title: "Fortune Winner: Claim Your Crown!", desc: "Claim your cash now—and unlock massive rewards next!",),
    LocalNotificationBean(notificationId: NotificationId.id1, title: "Opportunity Arrived!", desc: "Opportunity has arrived! Claim your reward!",),
    LocalNotificationBean(notificationId: NotificationId.id1, title: "Special Gift Awaiting!", desc: "pecial gift waiting! Tap to reveal!",),
    LocalNotificationBean(notificationId: NotificationId.id1, title: "Win Instant Cash Now!", desc: "Lucky Spin Available! Win Instant Cash!",),
  ];

  final List<LocalNotificationBean> _notificationList6_10=[
    LocalNotificationBean(notificationId: NotificationId.id2, title: "Top Gamers Cash Out!", desc: "Top Gamers Earn Huge! Instant Cash Rewards!",),
    LocalNotificationBean(notificationId: NotificationId.id2, title: "Tripeak Challenge Unlocked!", desc: "New level unlocked—clear the peaks to claim 500 coins! Your next move could win big!",),
    LocalNotificationBean(notificationId: NotificationId.id2, title: "Instant Win Available!", desc: "Play a game and win 50 coins instantly! Your next move could be a winner.",),
    LocalNotificationBean(notificationId: NotificationId.id2, title: "Tripeak Streak—Keep Winning!", desc: "Your 3 - day win streak earns a lucky spin! Break the peaks for instant rewards now.",),
    LocalNotificationBean(notificationId: NotificationId.id2, title: "Today’s Free Coins!", desc: "Log in today to get 200 free coins. Simple as that—start playing!",),
  ];
  final List<LocalNotificationBean> _notificationList11_15=[
    LocalNotificationBean(notificationId: NotificationId.id3, title: "Tripeak Win Time!", desc: "Play a Tripeak round, win loads of cash. Simple and rewarding!",),
    LocalNotificationBean(notificationId: NotificationId.id3, title: "Spin for Big Rewards!", desc: "Your spin is ready—turn it to get heaps of cash now!",),
    LocalNotificationBean(notificationId: NotificationId.id3, title: "Flip & Earn More!", desc: "Flip a card, score plenty of cash. Try your luck today!",),
    LocalNotificationBean(notificationId: NotificationId.id3, title: "Tripeak Streak Bonus!", desc: "3 Tripeak wins in a row = tons of cash. Keep going!",),
    LocalNotificationBean(notificationId: NotificationId.id3, title: "Free Spin Alert!", desc: "You’ve got a free spin—use it for loads of cash before it’s gone!",),
  ];

  final List<LocalNotificationBean> _notificationList16_20=[
    LocalNotificationBean(notificationId: NotificationId.id4, title: "Tripeak Daily Gift!", desc: "Log in, play 1 Tripeak game, get piles of cash. No catch!",),
    LocalNotificationBean(notificationId: NotificationId.id4, title: "Lucky Card Flip!", desc: "Today’s lucky flip—tap to get loads of cash for your next win!",),
    LocalNotificationBean(notificationId: NotificationId.id4, title: "Spin & Score!", desc: "Special spin today—win heaps of cash. Don’t miss it!",),
    LocalNotificationBean(notificationId: NotificationId.id4, title: "Tripeak Quick Win!", desc: "Finish a Tripeak round fast, get extra cash. Hurry up!",),
    LocalNotificationBean(notificationId: NotificationId.id4, title: "Card Flip Surprise!", desc: "Flip a card, find loads of cash. It’s your turn!",),
  ];

  final List<LocalNotificationBean> _notificationList21_25=[
    LocalNotificationBean(notificationId: NotificationId.id5, title: "Tripeak Bonus Round!", desc: "Clear this level, unlock a round with tons of cash. Go for it!",),
    LocalNotificationBean(notificationId: NotificationId.id5, title: "Spin Reminder!", desc: "2 spins left—use them for heaps of cash. Do it now!",),
    LocalNotificationBean(notificationId: NotificationId.id5, title: "Flip Streak Win!", desc: "5 card flips in a row = loads of cash. Keep flipping!",),
    LocalNotificationBean(notificationId: NotificationId.id5, title: "Tripeak New Level!", desc: "New Tripeak level—play it for piles of cash. Check it out!",),
    LocalNotificationBean(notificationId: NotificationId.id5, title: "Lucky Spin Time!", desc: "Today’s spin has extra cash—turn it for loads!",),
  ];
  final List<LocalNotificationBean> _notificationList26_30=[
    LocalNotificationBean(notificationId: NotificationId.id6, title: "Tripeak Coin Rush!", desc: "Play 3 Tripeak rounds, get tons of cash. Start now!",),
    LocalNotificationBean(notificationId: NotificationId.id6, title: "Card Flip Bonus!", desc: "Your flip today gives extra cash—tap to get heaps!",),
    LocalNotificationBean(notificationId: NotificationId.id6, title: "Spin & Win More!", desc: "Next spin gives double cash—get loads with one turn!",),
    LocalNotificationBean(notificationId: NotificationId.id6, title: "Tripeak Master Win!", desc: "Win a hard Tripeak round, get piles of cash. You can do it!",),
    LocalNotificationBean(notificationId: NotificationId.id6, title: "Daily Flip Gift!", desc: "Daily flip is ready—tap to win loads of cash. Easy!",),
  ];

  final List<LocalNotificationBean> _notificationList31_35=[
    LocalNotificationBean(notificationId: NotificationId.id7, title: "Tripeak Spin Reward!", desc: "Win a Tripeak round, get a free spin for heaps of cash!",),
    LocalNotificationBean(notificationId: NotificationId.id7, title: "Flip & Multiply!", desc: "Flip 2 same cards, multiply your next cash. Try now!",),
    LocalNotificationBean(notificationId: NotificationId.id7, title: "Spin Jackpot Chance!", desc: "Spin now—big chance to get loads of cash. Lucky you!",),
    LocalNotificationBean(notificationId: NotificationId.id7, title: "Tripeak Daily Streak!", desc: "3-day Tripeak streak = tons of cash. Keep it up!",),
    LocalNotificationBean(notificationId: NotificationId.id7, title: "Card Flip Alert!", desc: "Special card today—flip it for loads of extra cash!",),
  ];
  final List<LocalNotificationBean> _notificationList36_40=[
    LocalNotificationBean(notificationId: NotificationId.id8, title: "Spin & Collect!", desc: "You won loads from your last spin—collect cash now!",),
    LocalNotificationBean(notificationId: NotificationId.id8, title: "Tripeak Fast Bonus!", desc: "Win 2 Tripeak rounds in 10 mins, get heaps of cash. Go!",),
    LocalNotificationBean(notificationId: NotificationId.id8, title: "Flip to Win Big!", desc: "Today’s flip goal—get loads of cash. You’re close!",),
    LocalNotificationBean(notificationId: NotificationId.id8, title: "Spin Time Limited!", desc: "Your spin expires soon—use it for tons of cash. Hurry!",),
    LocalNotificationBean(notificationId: NotificationId.id8, title: "Tripeak New Gift!", desc: "Play a new Tripeak level, get piles of cash. Check it!",),
  ];
  final List<LocalNotificationBean> _notificationList41_45=[
    LocalNotificationBean(notificationId: NotificationId.id9, title: "Card Flip Streak Bonus!", desc: "7-day flip streak = loads of cash. Don’t stop!",),
    LocalNotificationBean(notificationId: NotificationId.id9, title: "Spin for More Cash!", desc: "Extra spins today—turn them to get heaps of cash. Yes!",),
    LocalNotificationBean(notificationId: NotificationId.id9, title: "Tripeak Win Bonus!", desc: "Every Tripeak win today gives extra cash. Play more!",),
    LocalNotificationBean(notificationId: NotificationId.id9, title: "Lucky Flip Time!", desc: "Your lucky flip—tap to get tons of cash. Try now!",),
    LocalNotificationBean(notificationId: NotificationId.id9, title: "Spin & Unlock!", desc: "Spin to unlock a Tripeak round with loads of cash. Do it!",),
  ];

  final List<LocalNotificationBean> _notificationList46_50=[
    LocalNotificationBean(notificationId: NotificationId.id10, title: "Tripeak Coin Bonus!", desc: "Use a hint, still win Tripeak—get extra cash. Nice!",),
    LocalNotificationBean(notificationId: NotificationId.id10, title: "Card Flip Surprise!", desc: "Hidden in today’s flip—loads of cash. Find it!",),
    LocalNotificationBean(notificationId: NotificationId.id10, title: "Spin Reward Boost!", desc: "Your next spin gives more—get tons of cash. Spin now!",),
    LocalNotificationBean(notificationId: NotificationId.id10, title: "Tripeak Streak Win!", desc: "6 Tripeak wins in a row = heaps of cash. Keep winning!",),
    LocalNotificationBean(notificationId: NotificationId.id10, title: "Daily Spin Gift!", desc: "Daily spin is here—turn it for loads of cash. Enjoy!",),
  ];

  setLocalNotifications()async{
    var plugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    var result = await plugin?.requestNotificationsPermission();
    if(result!=true){
      return;
    }
    FirebaseMessaging.instance.subscribeToTopic("adventurewin_tips");
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    var initResult = await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _clickLocalNotification(response.id);
      },
    );
    _checkFromLaunch();
    if(initResult!=true){
      return;
    }
    _postNotification(_notificationList1_5.random());
    _postNotification(_notificationList6_10.random());
    _postNotification(_notificationList11_15.random());
    _postNotification(_notificationList16_20.random());
    _postNotification(_notificationList21_25.random());
    _postNotification(_notificationList26_30.random());
    _postNotification(_notificationList31_35.random());
    _postNotification(_notificationList36_40.random());
    _postNotification(_notificationList41_45.random());
    _postNotification(_notificationList46_50.random());
  }

  _postNotification(LocalNotificationBean bean)async{
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'solitaire_channel_${bean.notificationId}',
      'solitaire_channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    await flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
      bean.notificationId,
      bean.title,
      bean.desc,
      kDebugMode?const Duration(seconds: 60):const Duration(minutes: 60),
      NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  _checkFromLaunch()async{
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      _clickLocalNotification(notificationAppLaunchDetails?.notificationResponse?.id);
    }
  }

  _clickLocalNotification(int? id){
    PointHep.instance.point(pointEvent: PointEvent.all_push_c,params: {"push_type":"id$id"});
  }
}