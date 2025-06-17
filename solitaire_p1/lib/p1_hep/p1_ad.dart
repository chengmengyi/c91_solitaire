import 'dart:convert';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:solitaire_p1/p1_hep/check_user/flutter_check_af.dart';
import 'package:solitaire_p1/p1_hep/facebook_utils.dart';
import 'package:solitaire_p1/p1_hep/firebase_hep.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';

StorageData<int> p3AdShowNum=StorageData<int>(key: "p3AdShowNum", defaultValue: 0);
StorageData<int> p3LastAdLevel=StorageData<int>(key: "p3LastAdLevel", defaultValue: 0);
StorageData<String> p3AdConfig=StorageData<String>(key: "p3AdConfig", defaultValue: "");


class P1AD{
  static final P1AD _instance = P1AD();
  static P1AD get instance => _instance;

  initAdInfo(){
    try{
      FlutterIosAdHep.instance.initMax(maxKey: maxKey.base64(), data: _getAdData(),);
    }catch(e){

    }
  }

  setAdInfo(){
    try{
      FlutterIosAdHep.instance.updateAdData(_getAdData());
    }catch(e){

    }
  }

  ConfigAdData _getAdData(){
    var ad = adStr.base64();
    if(p3AdConfig.getData().isNotEmpty){
      ad=p3AdConfig.getData();
    }
    var json = jsonDecode(ad);
    return ConfigAdData(
      maxShowNum: json["wbpryjrf"],
      maxClickNum: json["gelxuwdg"],
      oneRewardList: _getAdList(json["vvslt_rv_one"]),
      oneInterList: _getAdList(json["vvslt_int_one"]),
      twoRewardList: _getAdList(json["vvslt_rv_two"]),
      twoInterList: _getAdList(json["vvslt_int_two"]),
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
    var hasCache = FlutterIosAdHep.instance.getCacheResultData(AdType.reward);
    if(null==hasCache){
      showToast("Ad loading failed, please try again later");
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: AdType.reward,
      iosAdCallback: IosAdCallback(
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
    PointHep.instance.point(pointEvent: PointEvent.vvslt_ad_chance,params: {"ad_pos_id":adEvent.name,"ad_type":adType.name});
    var hasCache = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==hasCache){
      FlutterIosAdHep.instance.loadAd(adType);
      // if(adType==AdType.interstitial){
      //   closeAd.call();
      //   return;
      // }
      // P1RouterFun.showDialog(
      //   w: AdLoadFailDialog(
      //     popScene: popScene,
      //     tryAgain: (){
      //       if(null!=FlutterIosAdHep.instance.getCacheResultData(AdType.reward)){
      //         _startShowAd(adType: adType,adEvent: adEvent, closeAd: closeAd);
      //       }
      //     },
      //   )
      // );
      // return;
      showToast("Ad loading failed, please try again later");
      closeAd.call();
      return;
    }
    _startShowAd(adType: adType,adEvent: adEvent, closeAd: closeAd);
  }

  _startShowAd({
    required AdType adType,
    required AdEvent adEvent,
    required Function() closeAd,
}){
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          _uploadAdLevel();
          P1Mp3Hep.instance.pauseMusic();
          PointHep.instance.adPoint(ad: ad, data: info, adEvent: adEvent);
          FlutterCheckAf.instance.uploadAdRevenue(ad?.networkName??"", ad?.revenue??0, ad?.adUnitId??"", adEvent.name);
          FacebookUtils.instance.logPurchase(ad);
        },
        showFail: (ad){
          P1Mp3Hep.instance.playMusic();
          PointHep.instance.point(pointEvent: PointEvent.vvslt_ad_impression_fail,params: {"ad_pos_id":adEvent.name,"ad_type":adType.name});
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
    PointHep.instance.point(pointEvent: PointEvent.vvslt_ad_chance,params: {"ad_pos_id":adEvent.name,"ad_type":adType.name});
    var hasCache = FlutterIosAdHep.instance.getCacheResultData(AdType.reward);
    if(null==hasCache){
      closeAd.call();
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          _uploadAdLevel();
          P1Mp3Hep.instance.pauseMusic();
          PointHep.instance.adPoint(ad: ad, data: info, adEvent: adEvent);
          FacebookUtils.instance.logPurchase(ad);
        },
        showFail: (ad){
          P1Mp3Hep.instance.playMusic();
          PointHep.instance.point(pointEvent: PointEvent.vvslt_ad_impression_fail,params: {"ad_pos_id":adEvent.name,"ad_type":adType.name});
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
}