import 'package:get/get.dart';
import 'package:solitaire_p2/page/p2_home/p2_home_page.dart';
import 'package:solitaire_p2/page/p2_level10/p2_level10_page.dart';
import 'package:solitaire_p2/page/p2_level20/p2_level20_page.dart';

class P2RoutersName{
  static const String p2Home="/p2/home";
  static const String p2Level10="/p2/level10";
  static const String p2Level20="/p2/level20";
}

class P2RoutersList{
  static final p2RoutersList=[
    GetPage(
        name: P2RoutersName.p2Home,
        page: ()=> P2HomePage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P2RoutersName.p2Level10,
        page: ()=> P2Level10Page(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: P2RoutersName.p2Level20,
        page: ()=> P2Level20Page(),
        transition: Transition.fadeIn
    ),
  ];
}