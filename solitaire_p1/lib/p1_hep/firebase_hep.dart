import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/hep.dart';
import 'package:solitaire_p1/p1_hep/ad_type_ben.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

StorageData<String> p3AdTypeConfig=StorageData<String>(key: "p3AdTypeConfig", defaultValue: "");


class FirebaseHep{
  static final FirebaseHep _instance = FirebaseHep();
  static FirebaseHep get instance => _instance;

  FirebaseRemoteConfig? _config;

  Function(String s)? valueCallback;

  initFirebase()async{
    try{
      _config=FirebaseRemoteConfig.instance;
      await _config?.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout:  const Duration(seconds: 10),
            minimumFetchInterval: const Duration(seconds: 1)
        ),
      );
      await _config?.fetchAndActivate();
      _getString();
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 2000),);
      initFirebase();
    }
  }

  _getString(){
    var s = _config?.getString("us_numbers")??"";
    if(s.isNotEmpty){
      valueCallback?.call(s);
    }
    var ad = _config?.getString("ad_newset")??"";
    if(ad.isNotEmpty){
      p3AdConfig.saveData(ad);
      P1AD.instance.setAdInfo();
    }
  }

  AdType getShowAdType(AdType adType){
    // if(adType==AdType.interstitial){
    //   var senceInt = _adTypeBen?.senceInt??"int";
    //   return senceInt=="int"?AdType.interstitial:AdType.reward;
    // }
    // if(adType==AdType.reward){
    //   var senceRv = _adTypeBen?.senceRv??"rv";
    //   return senceRv=="rv"?AdType.reward:AdType.interstitial;
    // }
    return adType;
  }

  AdType getOpenAdType(){
    // var senceOpen = _adTypeBen?.senceOpen??"int";
    // return senceOpen=="int"?AdType.interstitial:AdType.reward;
    return AdType.interstitial;
  }
}