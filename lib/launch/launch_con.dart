import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/check_user_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';

StorageData<bool> firstLaunch=StorageData<bool>(key: "firstLaunch", defaultValue: true);

class LaunchCon extends P1BaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.launch_page);
    _initAnimator();
  }

  @override
  void onReady() {
    super.onReady();
    if(!firstLaunch.getData()){
      animationController.forward();
    }
    AppTrackingTransparency.requestTrackingAuthorization();
  }

  _initAnimator()async{
    animationController=AnimationController(duration: const Duration(seconds: 13),vsync: this)
      ..addListener(() {
        update(["progress"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          clickPlay();
        }
      });
  }

  clickPlay(){
    var user = CheckUserHep.instance.checkUser();
    if(true){
      if(firstLaunch.getData()){
        firstLaunch.saveData(false);
        P1RouterFun.toNextPageAndCloseCurrent(str: P3RoutersName.p3Home);
        return;
      }
      P1AD.instance.showOpenAd(
        adEvent: AdEvent.vvslt_launch,
        closeAd: (){
          P1RouterFun.toNextPageAndCloseCurrent(str: P3RoutersName.p3Home);
        },
      );
    }else{
      P1RouterFun.toNextPageAndCloseCurrent(str: P2RoutersName.p2Home);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}