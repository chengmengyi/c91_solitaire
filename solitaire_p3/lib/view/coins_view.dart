import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';

class CoinsView extends StatefulWidget{
  bool canClick;
  CoinsView({this.canClick=true});

  @override
  State<StatefulWidget> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView>{
  var currentCoins=p3Coins.getData();
  Timer? _addCoinsTimer;
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.updateCoins:
          _startAddCoinsTimer();
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: (){
      if(widget.canClick){
        P1RouterFun.toNextPage(str: P3RoutersName.p3cash);
      }
    },
    child: SizedBox(
      width: 160.w,
      height: 46.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          P1Image(name: "coins1",width: 160.w,height: 46.h,),
          Row(
            children: [
              SizedBox(width: 40.w,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 46.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 4.h),
                  child: P1Text(text: "\$$currentCoins", size: 15.sp, color: "#32F449",),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );

  _startAddCoinsTimer(){
    if(null!=_addCoinsTimer){
      return;
    }
    var total=50,current=0;
    // var d = ((Decimal.parse("${p3Coins.getData()}")-Decimal.parse("$currentCoins"))/Decimal.parse("$total")).toDouble().toStringAsFixed(3).toDou();
    var d = ((Decimal.parse("${p3Coins.getData()}")-Decimal.parse("$currentCoins"))/Decimal.parse("$total")).toDouble();
    _addCoinsTimer=Timer.periodic(const Duration(milliseconds: 10), (timer) {
      current++;
      setState(() {
        currentCoins=(Decimal.parse("$currentCoins")+Decimal.parse("$d")).toDouble();
      });
      if(current>=total){
        _addCoinsTimer?.cancel();
        _addCoinsTimer=null;
        setState(() {
          currentCoins=p3Coins.getData();
        });
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription=null;
    _addCoinsTimer?.cancel();
    _addCoinsTimer=null;
    super.dispose();
  }
}