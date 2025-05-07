import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/hep.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class WindAnimatorView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WindAnimatorViewState();
}

class _WindAnimatorViewState extends State<WindAnimatorView>  with SingleTickerProviderStateMixin{
  bool showCard=false;
  List<CardBean> cardList=[];
  late StreamSubscription<P1EventBean>? _streamSubscription;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _rotationAnimation;
  late AnimationStatusListener _statusListener;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.longJuanFengLottieEnd:
          cardList = bean.anyValue as List<CardBean>;
          setState(() {
            showCard=true;
          });
          _controller..reset()..forward();
          break;
      }
    });
    _initAnimator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => showCard?
  AnimatedBuilder(
    animation: _controller,
    builder: (context, child) {
      return Transform.translate(
        offset: _offsetAnimation.value * MediaQuery.of(context).size.width,
        child: Transform.rotate(
          angle: _rotationAnimation.value * 2 * 3.1415926 * 2,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        ),
      );
    },
    child: Stack(
      children: List.generate(cardList.length, (index){
        var bean = cardList[index];
        var renderBox = bean.globalKey.currentContext!.findRenderObject() as RenderBox;
        var offset = renderBox.localToGlobal(Offset.zero);
        return Positioned(
          top: offset.dy,
          left: offset.dx,
          child: P1Image(name: getCardImageIcon(bean),width: 50.w,height: 78.h,),
        );
      }),
    ),
  ):
  Container();

  _initAnimator(){
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(2.0, -2.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _statusListener=(status){
      if(status==AnimationStatus.completed){
        setState(() {
          showCard=false;
        });
        var addNum = (Decimal.parse("${P3ValueHep.instance.getCardAddNum()}")*Decimal.fromInt(cardList.length)).toDouble();
        P3UserInfoHep.instance.updateUserCoins(addNum);
        P1EventBean(code: P3EventCode.completedWindAnimator).send();
      }
    };
    _controller.addStatusListener(_statusListener);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.dispose();
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}