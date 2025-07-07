import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/rank_task_bean.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';
import 'package:solitaire_p3/hep/guide/rank_guide_view.dart';
import 'package:solitaire_p3/hep/hep.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';

class P3RankDialogController extends P1BaseCon{
  RankTaskBean? rankTaskBean;
  List<String> rankList=[];
  GlobalKey contentGlobalKey=GlobalKey();

  init(RankTaskBean? rankTaskBean){
    this.rankTaskBean=rankTaskBean;
  }

  @override
  void onReady() {
    super.onReady();
    _initRankList();
  }

  _initRankList()async{
    rankList.clear();
    var totalPro = (rankTaskBean?.totalPro??0)-1;
    for(var index=0;index<totalPro;index++){
      if(Random().nextInt(10)<5){
        rankList.add(generatePhoneNumber());
      }else{
        rankList.add(generateEmail());
      }
    }
    var currentPro = rankTaskBean?.currentPro??0;
    var account = rankTaskBean?.account??"";
    if(currentPro<=0){
      rankList.insert(0, account);
    }else{
      rankList.insert(currentPro-1, account);
    }
    update(["rank"]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _showFingerGuide();
    });
  }

  _showFingerGuide(){
    if(!p3FirstShowRankGuide.getData()){
      return;
    }
    var renderBox = contentGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    GuideHep.instance.showOverlay(
      context: context,
      widget: RankGuideView(
        offset: offset,
        size: renderBox.size,
        clickCall: (){
          p3FirstShowRankGuide.saveData(false);
          clickSkip();
        },
      ),
    );
  }

  clickSkip(){
    P1AD.instance.showAdByBPackage(
      adType: AdType.reward,
      showAd: kDebugMode?false:true,
      adEvent: AdEvent.vvslt_launch,
      closeAd: ()async{
        var result = await CashTaskHep.instance.updateRankTask(rankTaskBean);
        if((result?.currentPro??0)<=1){
          P1RouterFun.closePage();
        }else{
          rankTaskBean=result;
          _initRankList();
        }
      },
    );
  }

  clickClose(){
    P1RouterFun.closePage();
  }

  String getAccountStr(String account){
    if(isEmail(account)){
      var lastIndex = account.lastIndexOf("@");
      var start = account.substring(0,lastIndex);
      if(start.length<=2){
        return account;
      }else{
        return "${start.substring(0,2)}***${account.substring(lastIndex,account.length)}";
      }
    }
    if(account.length<=5){
      return "${account.substring(0,1)}*";
    }
    return "${account.substring(0,1)}***${account.substring(account.length-3,account.length)}";
  }
}