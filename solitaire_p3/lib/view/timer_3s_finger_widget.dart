import 'dart:async';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p3/bean/card_bean.dart';

class Timer3sFingerWidget extends StatefulWidget{
  Function(CardBean cardBean) clickCard;
  Timer3sFingerWidget({
    required this.clickCard,
});

  @override
  State<StatefulWidget> createState() => _Timer3sFingerWidgetState();
}

class _Timer3sFingerWidgetState extends State<Timer3sFingerWidget>{
  var showFinger=false;
  Offset? offset;
  CardBean? cardBean;
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.timer3sFinger:
          _checkShowFinger(bean);
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    if(!showFinger){
      return Container();
    }
    if(null==offset){
      return Stack(
        children: [
          Positioned(
            left: 50.w,
            bottom: 0,
            child: InkWell(
              onTap: (){
                setState(() {
                  showFinger=false;
                  offset=null;
                  cardBean=null;
                });
                P1EventBean(code: P3EventCode.clickHandCardFromTimer3sFinger).send();
              },
              child: P1LottieView(name: "finger",width: 72.w,height: 72.w,),
            ),
          )
        ],
      );
    }
    var dy = offset?.dy??0;
    var dx = offset?.dx??0;
    return Stack(
      children: [
        Positioned(
          top: dy+39.h,
          left: dx+25.w,
          child: InkWell(
            onTap: (){
              if(null!=cardBean){
                widget.clickCard.call(cardBean!);
              }
              setState(() {
                showFinger=false;
                offset=null;
                cardBean=null;
              });
            },
            child: P1LottieView(name: "finger",width: 72.w,height: 72.w,),
          ),
        ),
      ],
    );
  }

  _checkShowFinger(P1EventBean bean){
    setState(() {
      showFinger=bean.boolValue??false;
    });
    var anyValue = bean.anyValue;
    if(null!=anyValue){
      var value = anyValue as CardBean;
      cardBean=value;
      var renderBox = value.globalKey.currentContext!.findRenderObject() as RenderBox;
      offset=renderBox.localToGlobal(Offset.zero);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}