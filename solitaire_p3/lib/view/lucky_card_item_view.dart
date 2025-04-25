import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/hep.dart';

class LuckyCardItemView extends StatefulWidget{
  int index;
  double addNum;
  Function() clickCall;
  LuckyCardItemView({
    required this.index,
    required this.addNum,
    required this.clickCall,
  });

  @override
  State<StatefulWidget> createState() => _CardItemViewState();
}

class _CardItemViewState extends State<LuckyCardItemView> with SingleTickerProviderStateMixin {
  double addNum=0.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  late StreamSubscription<P1EventBean>? _streamSubscription;
  bool _isFront = false,_canClick=true,_sendEndMsg=false;

  @override
  void initState() {
    super.initState();
    addNum=widget.addNum;
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.flipLuckyCardEnd:
          if(widget.index!=bean.intValue){
            flipLuckyCardEnd();
          }
          break;
      }
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isFront=!_isFront;
        });
        _controller.reverse();
        if(_sendEndMsg){
          P1EventBean(code: P3EventCode.flipLuckyCardEnd,intValue: widget.index).send();
          widget.clickCall.call();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      if (_controller.isAnimating||!_canClick){
        return;
      }
      _sendEndMsg=true;
      _controller.forward();
    },
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final angle = _animation.value * 3.1415926;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: Opacity(
            opacity: angle <= 3.1415926 / 2 ? 1 : 0,
            child: _isFront ?
            _frontWidget() :
            Transform(
              transform: Matrix4.identity()..rotateY(3.1415926),
              alignment: Alignment.center,
              child: _backWidget(),
            ),
          ),
        );
      },
    ),
  );

  _frontWidget()=>Stack(
    alignment: Alignment.center,
    children: [
      P1Image(name: "card3",height: 145.h,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              P1Image(name: "home9",width: 66.w,height: 66.h,),
              Visibility(
                visible: !_canClick,
                child: P1Image(name: "card4",width: 59.w,height: 23.h,),
              ),
            ],
          ),
          SizedBox(height: 6.h,),
          P1Text(text: "+\$$addNum", size: 16.sp, color: "#008104",showShadows: false,),
        ],
      )
    ],
  );

  _backWidget()=>P1Image(name: "card2",height: 145.h,);

  flipLuckyCardEnd(){
    _canClick=false;
    var i = Random().nextInt(81)+20;
    addNum=(Decimal.fromInt(i)*Decimal.parse("${widget.addNum}")/Decimal.fromInt(100)).toDouble();
    setState(() {});
    Future.delayed(const Duration(milliseconds: 800),(){
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription=null;
    _controller.dispose();
    super.dispose();
  }
}