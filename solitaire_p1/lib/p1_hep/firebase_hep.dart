import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/hep.dart';
import 'package:solitaire_p1/p1_hep/ad_type_ben.dart';
import 'package:solitaire_p1/p1_hep/facebook_utils.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

StorageData<String> p3AdTypeConfig=StorageData<String>(key: "p3AdTypeConfig", defaultValue: "");
StorageData<String> p3FacebookConfig=StorageData<String>(key: "p3FacebookConfig", defaultValue: "");


class FirebaseHep{
  static final FirebaseHep _instance = FirebaseHep();
  static FirebaseHep get instance => _instance;

  FirebaseRemoteConfig? _config;

  Function(String s)? valueCallback;

  AdTypeBen? _adTypeBen;

  initFirebase()async{
    _initAdTypeBean();
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
    var ad = _config?.getString("vvslt_ad_config")??"";
    if(ad.isNotEmpty){
      p3AdConfig.saveData(ad);
      P1AD.instance.setAdInfo();
    }

    var ad_type = _config?.getString("ad_type")??"";
    if(ad_type.isNotEmpty){
      "adtype config-->${ad_type}".log();
      p3AdTypeConfig.saveData(ad_type);
      _initAdTypeBean();
    }
    var facebookStr = _config?.getString("adventurewin_fb_inform")??"";
    if(facebookStr.isNotEmpty){
      p3FacebookConfig.saveData(facebookStr);
    }
    FacebookUtils.instance.initFacebook();
  }

  AdType getShowAdType(AdType adType){
    if(adType==AdType.interstitial){
      var senceInt = _adTypeBen?.senceInt??"int";
      return senceInt=="int"?AdType.interstitial:AdType.reward;
    }
    if(adType==AdType.reward){
      var senceRv = _adTypeBen?.senceRv??"rv";
      return senceRv=="rv"?AdType.reward:AdType.interstitial;
    }
    return adType;
  }

  AdType getOpenAdType(){
    var senceOpen = _adTypeBen?.senceOpen??"int";
    return senceOpen=="int"?AdType.interstitial:AdType.reward;
  }

  test(){
    print("kkkk====${_adTypeBen?.toString()}");
  }

  _initAdTypeBean(){
    try{
      var data = p3AdTypeConfig.getData();
      if(data.isEmpty){
        data=adTypeLocal.base64();
      }
      _adTypeBen=AdTypeBen.fromJson(jsonDecode(data));
    }catch(e){
      _adTypeBen=AdTypeBen.fromJson(jsonDecode(adTypeLocal.base64()));
    }
  }
}