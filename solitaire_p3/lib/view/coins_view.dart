import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';

class CoinsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView>{
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P2EventCode.updateCoins:
          setState(() {});
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 118.w,
    height: 32.h,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        P1Image(name: "coins1",width: 118.w,height: 32.h,),
        Row(
          children: [
            SizedBox(width: 2.w,),
            P1Image(name: "coins2",width: 30.w,height: 30.h,),
            Expanded(
              child: Center(
                child: P1Text(text: "${p2Coins.getData()}", size: 15.sp, color: "#FFFFFF",),
              ),
            ),
            SizedBox(width: 6.w,),
          ],
        )
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