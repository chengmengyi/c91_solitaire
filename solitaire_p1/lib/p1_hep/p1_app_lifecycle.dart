import 'dart:async';

import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';

class P1AppLifecycleUtils{
  static final P1AppLifecycleUtils _instance = P1AppLifecycleUtils();
  static P1AppLifecycleUtils get instance => _instance;
  Timer? _pausedTimer;
  var _isBack=false;

  add(){
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (back){
          if(back){
            _startPausedTimer();
          }else{
            _checkToLaunchPage();
          }
        },
      ),
    );
  }

  _startPausedTimer(){
    _pausedTimer=Timer(const Duration(milliseconds: 3000), () {
      _isBack=true;
    });
  }

  _checkToLaunchPage(){
    PointHep.instance.session();
    _pausedTimer?.cancel();
    Future.delayed(const Duration(milliseconds: 100),(){
      if(_isBack&&!FlutterIosAdHep.instance.adShowing()){
        P1AD.instance.showOpenAd(
          adEvent: AdEvent.vvslt_launch,
          closeAd: (){
          },
        );
      }
      _isBack=false;
    });
  }
}