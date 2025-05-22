import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
class TopProView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TopProViewState();

}
class TopProViewState extends State<TopProView>{
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.updateTopPro:
          setState(() {});
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 12.w,right: 12.w),
    child: Stack(
      children: [
        Stack(
          children: [
            P1Image(name: "pro1",width: double.infinity,height: 44.h,),
            Container(
              margin: EdgeInsets.only(top: 14.h,left: 12.w,right: 30.w),
              child: LayoutBuilder(
                builder: (context,bc){
                  var maxWidth = bc.maxWidth;
                  return Container(
                    width: double.infinity,
                    height: 14.h,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 2.w,right: 2.w),
                    decoration: BoxDecoration(
                      color: "#3E0000".toColor(),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Container(
                      width: maxWidth*getPro(),
                      height: 8.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: ["#FFC800".toColor(),"#FF7823".toColor()],
                          )
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: P1Image(name: p3LastIsLuckyCard.getData()?"pro3":"pro2",width: 44.w,height: 48.h,),
            )
          ],
        )
      ],
    ),
  );


  double getPro(){
    var d = p3TopPro.getData()/5;
    if(d<=0){
      return 0.0;
    }else if(d>=1.0){
      return 1.0;
    }else{
      return d;
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}