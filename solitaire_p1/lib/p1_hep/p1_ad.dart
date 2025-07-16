import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_topon_ad_plugins/callback/topon_ad_callback.dart';
import 'package:flutter_topon_ad_plugins/callback/topon_load_ad_result_callback.dart';
import 'package:flutter_topon_ad_plugins/data/ad_info_data.dart';
import 'package:flutter_topon_ad_plugins/data/config_ad_data.dart';
import 'package:flutter_topon_ad_plugins/flutter_topon_ad_plugins.dart';
import 'package:solitaire_p1/p1_base/p3_ad_load_fail/ad_load_fail_dialog.dart';
import 'package:solitaire_p1/p1_hep/check_user/flutter_check_af.dart';
import 'package:solitaire_p1/p1_hep/firebase_hep.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';

StorageData<int> p3AdShowNum=StorageData<int>(key: "p3AdShowNum", defaultValue: 0);
StorageData<int> p3LastAdLevel=StorageData<int>(key: "p3LastAdLevel", defaultValue: 0);
StorageData<String> p3AdConfig=StorageData<String>(key: "p3AdConfigTopon", defaultValue: "");


class P1AD{
  static final P1AD _instance = P1AD();
  static P1AD get instance => _instance;

  initAdInfo(){
    try{
      FlutterToponAdPlugins.instance.initTopon(
        topOnAppId: toponId.base64(),
        topOnAppKey: toponIKey.base64(),
        data: _getAdData(),
        toponLoadAdResultCallback: ToponLoadAdResultCallback(
          startLoadAdCallback: (adInfo){
            PointHep.instance.point(
              pointEvent: PointEvent.ad_request,
              // ad_code_id/ad_format/ad_platform
              params: {
                "ad_code_id":adInfo?.adId,
                "ad_format":adInfo?.adType.name,
                "ad_platform":adInfo?.adPlat,
              },
            );
          },
          loadAdSuccessCallback: (ad,adInfo){},
          loadAdFailCallback: (adInfo){},
        ),
      );
    }catch(e){
    }
  }

  setAdInfo(){
    try{
      FlutterToponAdPlugins.instance.updateAdData(_getAdData());
    }catch(e){

    }
  }

  ConfigAdData _getAdData(){
    var ad = adStr.base64();
    if(p3AdConfig.getData().isNotEmpty){
      ad=p3AdConfig.getData();
    }

    print("flutter ios ad --->$ad");
    var json = jsonDecode(ad);
    return ConfigAdData(
      maxShowNum: json["wbpryjrf"],
      maxClickNum: json["gelxuwdg"],
      oneRewardList: _getAdList(json["xalgqzsn"]["vvslt_rv_one"]),
      oneInterList: _getAdList(json["wonfkogt"]["vvslt_int_one"]),
      twoRewardList: _getAdList(json["xalgqzsn"]["vvslt_rv_two"]),
      twoInterList: _getAdList(json["wonfkogt"]["vvslt_int_two"]),
    );
  }

  List<AdInfoData> _getAdList(List? list){
    if(null==list){
      return [];
    }
    List<AdInfoData> resultList=[];
    for (var value in list) {
      resultList.add(
          AdInfoData(
            adId: value["idirgkyd"],
            adPlat: value["lurwymeq"],
            adType: value["ehpdicim"]=="reward"?AdType.reward:AdType.interstitial,
            expireTime: value["guxxklrg"],
            sort: value["lugbfdap"],
          )
      );
    }
    return resultList;
  }

  //a 包显示广告
  showAdByAPackage({
    required Function() closeAd,
}){
    var hasCache = FlutterToponAdPlugins.instance.getCacheResultData(AdType.reward);
    if(null==hasCache){
      showToast("Ad loading failed, please try again later");
      return;
    }
    FlutterToponAdPlugins.instance.showAd(
      adType: AdType.reward,
      toponAdCallback: ToponAdCallback(
        showSuccess: (ad,info){
          P1Mp3Hep.instance.pauseMusic();
        },
        showFail: (ad){
          P1Mp3Hep.instance.playMusic();
        },
        closeAd: (){
          P1Mp3Hep.instance.playMusic();
          closeAd.call();
        },
        onAdRevenuePaidCallback: (ad,info){},
      ),
    );
  }

  //B包显示广告
  showAdByBPackage({
    required AdType adType,
    required bool showAd,
    required AdEvent adEvent,
    String popScene="other",
    required Function() closeAd,
  }){
    if(!showAd){
      closeAd.call();
      return;
    }
    PointHep.instance.point(pointEvent: PointEvent.vvslt_ad_chance,params: {"ad_pos_id":adEvent.name,"ad_format":adType.name});
    var hasCache = FlutterToponAdPlugins.instance.getCacheResultData(adType);
    if(null==hasCache){
      FlutterToponAdPlugins.instance.loadAdWhenNoCache(adType);
      if(adType==AdType.interstitial){
        closeAd.call();
      }else{
        showToast("Ad loading failed, please try again later");
      }
      return;
    }
    _startShowAd(adType: adType,adEvent: adEvent, closeAd: closeAd);
  }

  _startShowAd({
    required AdType adType,
    required AdEvent adEvent,
    required Function() closeAd,
}){
    FlutterToponAdPlugins.instance.showAd(
      adType: adType,
      toponAdCallback: ToponAdCallback(
        showSuccess: (ad,info){
          _uploadAdLevel();
          P1Mp3Hep.instance.pauseMusic();
          PointHep.instance.adPoint(ad: ad, data: info, adEvent: adEvent);
          FlutterCheckAf.instance.uploadAdRevenue(ad?.networkName??"", ad?.revenue??0, ad?.adUnitId??"", adEvent.name);
        },
        showFail: (ad){
          P1Mp3Hep.instance.playMusic();
          PointHep.instance.point(pointEvent: PointEvent.vvslt_ad_impression_fail,params: {"ad_pos_id":adEvent.name,"ad_format":adType.name});
        },
        closeAd: (){
          P1Mp3Hep.instance.playMusic();
          closeAd.call();
        },
        onAdRevenuePaidCallback: (ad,info){},
      ),
    );
  }

  showOpenAd({
    required AdEvent adEvent,
    required Function() closeAd,
  }){
    var adType = FirebaseHep.instance.getOpenAdType();
    PointHep.instance.point(pointEvent: PointEvent.vvslt_ad_chance,params: {"ad_pos_id":adEvent.name,"ad_format":adType.name});
    var hasCache = FlutterToponAdPlugins.instance.getCacheResultData(AdType.reward);
    if(null==hasCache){
      closeAd.call();
      return;
    }
    FlutterToponAdPlugins.instance.showAd(
      adType: adType,
      toponAdCallback: ToponAdCallback(
        showSuccess: (ad,info){
          _uploadAdLevel();
          P1Mp3Hep.instance.pauseMusic();
          PointHep.instance.adPoint(ad: ad, data: info, adEvent: adEvent);
        },
        showFail: (ad){
          P1Mp3Hep.instance.playMusic();
          PointHep.instance.point(pointEvent: PointEvent.vvslt_ad_impression_fail,params: {"ad_pos_id":adEvent.name,"ad_format":adType.name});
          closeAd.call();
        },
        closeAd: (){
          P1Mp3Hep.instance.playMusic();
          closeAd.call();
        },
        onAdRevenuePaidCallback: (ad,info){},
      ),
    );
  }

  _uploadAdLevel(){
    p3AdShowNum.saveData(p3AdShowNum.getData()+1);
    var adLevel = p3LastAdLevel.getData()+5;
    if(p3AdShowNum.getData()>=adLevel){
      PointHep.instance.point(pointEvent: PointEvent.pv_dall,params: {"pv_numbers":adLevel});
      p3LastAdLevel.saveData(adLevel);
    }
  }

  List<AdInfoData> _getNewList(Map? map){
    if(null==map){
      return [];
    }
    var intOne=_getAdList(map["vvslt_int_one"]);
    var intTwo=_getAdList(map["vvslt_int_two"]);
    var rvOne=_getAdList(map["vvslt_rv_one"]);
    var rvTwo=_getAdList(map["vvslt_rv_two"]);
    return intOne+intTwo+rvOne+rvTwo;
  }
}