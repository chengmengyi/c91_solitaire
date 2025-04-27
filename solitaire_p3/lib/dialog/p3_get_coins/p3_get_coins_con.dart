import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';

class P3GetCoinsCon extends P1BaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

  }

  clickDou(double addNum){
    P1RouterFun.closePage();
    P3UserInfoHep.instance.updateUserCoins(addNum*2);
  }

  clickSingle(double addNum){
    P1RouterFun.closePage();
    P3UserInfoHep.instance.updateUserCoins(addNum);
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}