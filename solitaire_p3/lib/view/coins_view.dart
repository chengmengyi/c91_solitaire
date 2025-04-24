import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';

class CoinsView extends StatefulWidget{
  bool canClick;
  CoinsView({this.canClick=true});

  @override
  State<StatefulWidget> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView>{
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.updateCoins:
          setState(() {});
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 145.w,
    height: 46.h,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        P1Image(name: "coins1",width: 145.w,height: 46.h,),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(left: 50.w,bottom: 8.h),
            child: P1Text(text: "\$${p3Coins.getData()}", size: 15.sp, color: "#32F449",),
          ),
        ),
      ],
    ),
  );

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}