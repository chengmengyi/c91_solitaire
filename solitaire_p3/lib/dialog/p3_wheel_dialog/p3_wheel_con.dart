import 'dart:math';

import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/wheel_bean.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3WheelCon extends P1BaseCon{
  var showBox=P3ValueHep.instance.checkWheelShowBox();
  var wheelAddNum=P3ValueHep.instance.getLuckyCardAddNum();
  List<WheelBean> coinsList=[];

  @override
  void onInit() {
    super.onInit();
    _initCoinsList();
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
    }else{
      coinsList.add(WheelBean(isBox: false, addNum: wheelAddNum.toInt()));
      while(coinsList.length<6){
        var i = Random().nextInt(81)+20;
        var add = (i*wheelAddNum/100).ceil();
        coinsList.add(WheelBean(isBox: false, addNum: add));
      }
      coinsList.shuffle();
    }

  }

  clickClose(){
    P3UserInfoHep.instance.updateTopPro(-5);
    P1RouterFun.closePage();
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
}