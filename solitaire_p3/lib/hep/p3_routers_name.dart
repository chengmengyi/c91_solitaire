import 'package:get/get.dart';
import 'package:solitaire_p3/page/p3_home/p3_home_page.dart';
import 'package:solitaire_p3/page/p3_level10/p3_level10_page.dart';
import 'package:solitaire_p3/page/p3_level20/p3_level20_page.dart';
import 'package:solitaire_p3/page/p3_web/p3_web_page.dart';

class P3RoutersName{
  static const String p3Home="/p3/home";
  static const String p3Level10="/p3/level10";
  static const String p3Level20="/p3/level20";
  static const String p3web="/p3/web";
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
  ];
}