import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';

abstract class P1BaseStatelessWidget<K extends P1BaseCon> extends StatelessWidget{
  late K p1Con;
  bool _isInit=true;

  @override
  Widget build(BuildContext context) {
    if(_isInit){
      p1Con=Get.put(initCon());
      initView();
    }
    _isInit=false;
    return initWidget();
  }

  initView(){}

  Widget initWidget();

  K initCon();
}