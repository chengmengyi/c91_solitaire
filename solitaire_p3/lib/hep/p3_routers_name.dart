import 'package:get/get.dart';
import 'package:solitaire_p3/page/p3_cash/p3_account/p3_account_page.dart';
import 'package:solitaire_p3/page/p3_cash/p3_cash/p3_cash_page.dart';
import 'package:solitaire_p3/page/p3_home/p3_home_page.dart';
import 'package:solitaire_p3/page/p3_level10/p3_level10_page.dart';
import 'package:solitaire_p3/page/p3_level20/p3_level20_page.dart';
import 'package:solitaire_p3/page/p3_level30/p3_level30_page.dart';
import 'package:solitaire_p3/page/p3_level40/p3_level40_page.dart';
import 'package:solitaire_p3/page/p3_level50/p3_level50_page.dart';
import 'package:solitaire_p3/page/p3_level60/p3_level60_page.dart';
import 'package:solitaire_p3/page/p3_level70/p3_level70_page.dart';
import 'package:solitaire_p3/page/p3_level90/p3_level90_page.dart';
import 'package:solitaire_p3/page/p3_web/p3_web_page.dart';

class P3RoutersName{
  static const String p3Home="/p3/home";
  static const String p3Level10="/p3/level10";
  static const String p3Level20="/p3/level20";
  static const String p3web="/p3/web";
  static const String p3cash="/p3/p3cash";
  static const String p3account="/p3/p3account";
  static const String p3Level30="/p3/p3Level30";
  static const String p3Level40="/p3/p3Level40";
  static const String p3Level50="/p3/p3Level50";
  static const String p3Level60="/p3/p3Level60";
  static const String p3Level70="/p3/p3Level70";
  static const String p3Level90="/p3/p3Level90";
}

class P3RoutersList{
  static final p3RoutersList=[
    GetPage(
        name: P3RoutersName.p3Home,
        page: ()=> P3HomePage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3Level10,
        page: ()=> P3Level10Page(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3Level20,
        page: ()=> P3Level20Page(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3web,
        page: ()=> P3WebPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3cash,
        page: ()=> P3CashPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3account,
        page: ()=> P3AccountPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3Level30,
        page: ()=> P3Level30Page(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3Level40,
        page: ()=> P3Level40Page(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3Level50,
        page: ()=> P3Level50Page(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3Level60,
        page: ()=> P3Level60Page(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3Level70,
        page: ()=> P3Level70Page(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P3RoutersName.p3Level90,
        page: ()=> P3Level90Page(),
        transition: Transition.fadeIn
    ),
  ];
}