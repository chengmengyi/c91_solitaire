import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';

StorageData<bool> firstLaunch=StorageData<bool>(key: "firstLaunch", defaultValue: true);

class LaunchCon extends P1BaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  @override
  void onReady() {
    super.onReady();
    if(!firstLaunch.getData()){
      animationController.forward();
    }
  }

  _initAnimator()async{
    animationController=AnimationController(duration: const Duration(seconds: 3),vsync: this)
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
    firstLaunch.saveData(false);
    P1RouterFun.toNextPageAndCloseCurrent(str: P2RoutersName.p2Home);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}