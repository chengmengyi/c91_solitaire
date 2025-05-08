import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/wheel_bean.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';
import 'package:solitaire_p3/hep/hep.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3WheelCon extends P1BaseCon with GetSingleTickerProviderStateMixin{
  var canClick=true;
  var showBox=P3ValueHep.instance.checkWheelShowBox();
  var wheelAddNum=P3ValueHep.instance.getLuckyCardAddNum();
  List<WheelBean> coinsList=[];
  late AnimationController _animationController;
  late Animation<double> animation;
  late AnimationStatusListener _statusListener;

  @override
  void onInit() {
    super.onInit();
    _initCoinsList();
    PointHep.instance.point(pointEvent: PointEvent.wheel_page,);
  }

  startAnimator(){
    if(!canClick){
      return;
    }
    PointHep.instance.point(pointEvent: PointEvent.wheel_page_c,);
    canClick=false;
    _animationController.forward();
  }

  _initCoinsList(){
    coinsList.clear();
    coinsList.add(WheelBean(isBox: false, addNum: 200));
    if(showBox){
      while(coinsList.length<8){
        if(coinsList.length==2||coinsList.length==4||coinsList.length==6){
          coinsList.add(WheelBean(isBox: true, addNum: 0));
        }else{
          coinsList.add(WheelBean(isBox: false, addNum: Random().nextInt(3)+1));
        }
      }
      coinsList = _randomSortExceptPositions();
      int angle = [90,180,270].random();
      _initAnimator(360-angle);
    }else{
      coinsList.add(WheelBean(isBox: false, addNum: wheelAddNum.toInt()));
      while(coinsList.length<8){
        var i = Random().nextInt(81)+20;
        var add = (i*wheelAddNum/100).ceil();
        coinsList.add(WheelBean(isBox: false, addNum: add));
      }
      coinsList.shuffle();
      var indexWhere = coinsList.indexWhere((element) => element.addNum==wheelAddNum.toInt());
      if(indexWhere>=0){
        _initAnimator(360-45*indexWhere);
      }
    }

  }

  clickClose(){
    if(!canClick){
      return;
    }
    P1AD.instance.showAdByBPackage(
      adType: AdType.interstitial,
      showAd: P3ValueHep.instance.showIntAd(AdType.interstitial),
      adEvent: AdEvent.vvslt_turntablepopclose_int,
      closeAd: (){
        P3UserInfoHep.instance.updateTopPro(-5);
        P1RouterFun.closePage();
      },
    );
  }

  _randomSortExceptPositions() {
    List<int> positions=[2,4,6];
    List<WheelBean> otherPositionsData = [];
    List<WheelBean> result = List<WheelBean>.filled(coinsList.length, WheelBean(isBox: false, addNum: 0));
    for (int i = 0; i < coinsList.length; i++) {
      if (positions.contains(i)) {
        result[i] = coinsList[i];
      } else {
        otherPositionsData.add(coinsList[i]);
      }
    }
    otherPositionsData.shuffle();
    int otherIndex = 0;
    for (int i = 0; i < coinsList.length; i++) {
      if (!positions.contains(i)) {
        result[i] = otherPositionsData[otherIndex];
        otherIndex++;
      }
    }
    return result;
  }

  _initAnimator(int angle){
    _animationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
    _statusListener=(status){
      if(status==AnimationStatus.completed){
        Future.delayed(const Duration(milliseconds: 1000),(){
          P1RouterFun.closePage();
          showGetCoinsDialog(wheelAddNum, GetCoinsEnum.wheel);
        });
      }
    };
    _animationController.addStatusListener(_statusListener);
    animation=Tween<double>(begin: 0,end: (720+angle)*(pi/180)).animate(_animationController);
  }

  @override
  void onClose() {
    _animationController.dispose();
    _animationController.removeStatusListener(_statusListener);
    super.onClose();
  }
}