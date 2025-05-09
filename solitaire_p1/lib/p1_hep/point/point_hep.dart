import 'dart:io';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';
import 'package:flutter_ad_ios_plugins/hep/hep.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:solitaire_p1/p1_hep/check_user/dio/dio_hep.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_sql.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:solitaire_p1/p1_hep/point/tba_sql.dart';


StorageData<bool> p2Install=StorageData<bool>(key: "install", defaultValue: false);


class PointHep{
  static final PointHep _instance = PointHep();
  static PointHep get instance => _instance;

  install({tryNum=5})async{
    if(p2Install.getData()){
      return;
    }
    point(pointEvent: PointEvent.install);
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    var headerMap = await _headerMap();
    var url = await _url(distinctId);
    var map = await _createBaseMap(distinctId);
    var referrerMap = await FlutterTbaInfo.instance.getReferrerMap();
    map["waldorf"]={
      "gentry":referrerMap["build"],
      "startup":referrerMap["referrer_url"],
      "box":referrerMap["install_version"],
      "ashame":referrerMap["user_agent"],
      "web":"estes",
      "adept":referrerMap["referrer_click_timestamp_seconds"],
      "globular":referrerMap["install_begin_timestamp_seconds"],
      "confound":referrerMap["referrer_click_timestamp_server_seconds"],
      "mona":referrerMap["install_begin_timestamp_server_seconds"],
      "minsky":referrerMap["install_first_seconds"],
      "thump":referrerMap["last_update_seconds"],
      "alundum":referrerMap["google_play_instant"],
    };
    "tba--->install--->start request-->params:$map".log();
    var dioResult = await DioHep.instance.requestPost(path: url, data: map,header: headerMap);
    "tba--->install--->request result-->${dioResult.success}--->params:$map".log();
    if(dioResult.success){
      p2Install.saveData(true);
    }else{
      if(tryNum>0){
        await Future.delayed(const Duration(milliseconds: 1000));
        install(tryNum: tryNum-1);
      }
    }
  }

  session({tryNum=5})async{
    point(pointEvent: PointEvent.session);
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    var headerMap = await _headerMap();
    var url = await _url(distinctId);
    var map = await _createBaseMap(distinctId);
    map["snobbish"]="hodge";
    "tba--->session--->start request-->params:$map".log();
    var dioResult = await DioHep.instance.requestPost(path: url, data: map,header: headerMap);
    "tba--->session--->request result-->${dioResult.success}--->params:$map".log();
    if(!dioResult.success&&tryNum>0){
      await Future.delayed(const Duration(milliseconds: 1000));
      session(tryNum: tryNum-1);
    }
  }

  point({required PointEvent pointEvent,Map<String,dynamic>? params,tryNum=5})async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    var headerMap = await _headerMap();
    var url = await _url(distinctId);
    var map = await _createBaseMap(distinctId);
    map["snobbish"]=pointEvent.name;
    if(params!=null){
      for (var value in params.keys) {
        map["$value|chimney"]=params[value];
      }
    }
    "tba--->point--->start request-->params:$map".log();
    var dioResult = await DioHep.instance.requestPost(path: url, data: map,header: headerMap);
    "tba--->point--->request result-->${dioResult.success}--->params:$map".log();
    if(!dioResult.success){
      if(tryNum>0){
        await Future.delayed(const Duration(milliseconds: 1000));
        point(pointEvent: pointEvent,params: params,tryNum: tryNum-1);
      }else{
        TbaSql.instance.insertTbaMap(map);
      }
    }
  }

  adPoint({required MaxAd? ad,required AdInfoData? data,required AdEvent adEvent,tryNum=5})async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    var headerMap = await _headerMap();
    var url = await _url(distinctId);
    var map = await _createBaseMap(distinctId);
    map["snobbish"]="singable";
    map["ms"]=(ad?.revenue??0)*1000000;
    map["snafu"]="USD";
    map["aliquot"]=ad?.networkName??"";
    map["puppyish"]=data?.adPlat??"";
    map["roadbed"]=data?.adId??"";
    map["factor"]=adEvent.name;
    map["wanton"]=data?.adType.name??"";
    map["extent"]=ad?.revenuePrecision??"";
    "tba--->ad--->start request-->params:$map".log();
    var dioResult = await DioHep.instance.requestPost(path: url, data: map,header: headerMap);
    "tba--->ad--->request result-->${dioResult.success}--->params:$map".log();
    if(!dioResult.success){
      if(tryNum>0){
        await Future.delayed(const Duration(milliseconds: 1000));
        adPoint(ad: ad, data: data, adEvent: adEvent,tryNum: tryNum-1);
      }else{
        TbaSql.instance.insertTbaMap(map);
      }
    }
  }

  Future<Map<String,dynamic>> _headerMap()async{
    return {"algal": await FlutterTbaInfo.instance.getDeviceModel()};
  }

  Future<String> _url(String distinctId)async{
    return "$tbaUrl?affair=$distinctId&cosgrove=${await FlutterTbaInfo.instance.getOperator()}";
  }

  Future<Map<String,dynamic>> _createBaseMap(String distinctId)async{
    Map<String,dynamic> map={};
    map["orono"]={
      "gallium": await FlutterTbaInfo.instance.getSystemLanguage(),
      "forth": await FlutterTbaInfo.instance.getBundleId(),
      "carousel": await FlutterTbaInfo.instance.getBrand(),
      "jury": await FlutterTbaInfo.instance.getGaid(),
      "plasma": await FlutterTbaInfo.instance.getNetworkType(),
      "affair": distinctId,
    };
    map["saviour"]={
      "carolyn": await FlutterTbaInfo.instance.getManufacturer(),
      "we": await FlutterTbaInfo.instance.getAndroidId(),
      "eve": await FlutterTbaInfo.instance.getIdfv(),
      "aquatic": await FlutterTbaInfo.instance.getAppVersion(),
    };
    map["quiz"]={
      "astoria": await FlutterTbaInfo.instance.getIdfa(),
      "shape": await FlutterTbaInfo.instance.getOsVersion(),
      "memo": await FlutterTbaInfo.instance.getLogId(),
      "cosgrove": await FlutterTbaInfo.instance.getOperator(),
      "algal": await FlutterTbaInfo.instance.getDeviceModel(),
      "nostril": await FlutterTbaInfo.instance.getOsCountry(),
      "jam":Platform.isAndroid?"prospect":"offprint",
      "gustav":DateTime.now().millisecondsSinceEpoch,
    };
    return map;
  }

  checkHasTbaMap()async{
    var tbaMap = await TbaSql.instance.queryTbaMap();
    "tba--->tba map--->params:$tbaMap".log();
    if(tbaMap.isNotEmpty){
      var distinctId = await FlutterTbaInfo.instance.getDistinctId();
      var headerMap = await _headerMap();
      headerMap["Content-Encoding"]="gzip";
      var url = await _url(distinctId);
      "tba--->tba map--->start request-->params:$tbaMap".log();
      var dioResult = await DioHep.instance.requestPost(
        path: url,
        data: headerMap,
        header: headerMap,
        contentType: "application/json",
      );
      if(dioResult.success){
        TbaSql.instance.removeTbaMap();
      }
      "tba--->tba map--->request result-->${dioResult.success}--->params:$tbaMap".log();
    }
  }
}