import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';

class HandCardRemoveView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HandCardRemoveViewState();
}

class _HandCardRemoveViewState extends State<HandCardRemoveView> with SingleTickerProviderStateMixin{
  var showCoinsLottie=false;
  late AnimationController _controller;
  late Animation<double> _animation;
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.showCoinsLottie:
          if(bean.boolValue==true){
            setState(() {
              showCoinsLottie=true;
            });
          }
          _controller..reset()..forward();
          break;
      }
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        setState(() {
          showCoinsLottie=false;
        });
      }
    });
    _animation = Tween<double>(
      begin: 0.1,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    return Visibility(
      visible: showCoinsLottie,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (ctx,child){
              return Positioned(
                left: 20.w,
                bottom: _animation.value*height,
                child: P1Image(name: "icon_money",width: 50.w,height: 50.w,),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}