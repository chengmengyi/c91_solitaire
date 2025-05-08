import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/hep.dart';

class MoveToHandCardAnimatorView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MoveToHandCardAnimatorViewState();
}

class _MoveToHandCardAnimatorViewState extends State<MoveToHandCardAnimatorView> with TickerProviderStateMixin{
  Offset? offset;
  CardBean? cardBean;
  Animation<Offset>? keyAnimation;
  late AnimationController _animationController;
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          setState(() {
            offset=null;
            cardBean=null;
          });
        }
      });
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.moveHandCardToBottom:
          cardBean=bean.anyValue as CardBean;
          _getCardOffset(bean.anyValue2 as Offset);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(null==cardBean||null==offset){
      return Container();
    }
    var value = keyAnimation?.value;
    var dx = value?.dx??0;
    var dy = value?.dy??0;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: dx<=0?0:dx,top: dy<=0?0:dy),
          child: P1Image(name: getCardImageIcon(cardBean!),width: 50.w,height: 78.h,),
        )
      ],
    );
  }

  _getCardOffset(Offset endOffset){
    if(null==cardBean){
      return;
    }
    var renderBox = cardBean?.globalKey.currentContext!.findRenderObject() as RenderBox;
    offset = renderBox.localToGlobal(Offset.zero);
    setState(() {});
    keyAnimation=Tween<Offset>(
      begin: offset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController..reset()..forward();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription=null;
    _animationController.dispose();
    super.dispose();
  }
}