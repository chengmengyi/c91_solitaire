import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/hep.dart';

class CardItemView extends StatefulWidget{
  CardBean cardBean;
  Function() clickCard;
  CardItemView({
    required this.cardBean,
    required this.clickCard,
  });

  @override
  State<StatefulWidget> createState() => _CardItemViewState();
}

class _CardItemViewState extends State<CardItemView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late StreamSubscription<P1EventBean>? _streamSubscription;
  bool _isFront = false;

  @override
  void initState() {
    super.initState();
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P2EventCode.flipCards:
          var list = bean.anyValue as List<CardBean>;
          var indexWhere = list.indexWhere((element) => element.index==widget.cardBean.index);
          if(indexWhere>=0&&!_isFront){
            if (_controller.isAnimating) return;
            _controller.forward();
          }
          break;
        case P2EventCode.resetCardFrontStatus:
          _isFront=false;
          _controller.reset();
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
          _isFront=!widget.cardBean.covered;
        });
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.cardBean.show){
      return SizedBox(width: 50.w,height: 78.h,);
    }
    return InkWell(
      onTap: () {
        widget.clickCard.call();
      },
      key: widget.cardBean.globalKey,
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
              _cardWidget() :
              Transform(
                transform: Matrix4.identity()..rotateY(3.1415926),
                alignment: Alignment.center,
                child: _cardWidget(),
              ),
            ),
          );
        },
      ),
    );
  }

  _cardWidget()=>P1Image(name: !_isFront?"card_back":getCardImageIcon(widget.cardBean),width: 50.w,height: 78.h,);

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription=null;
    _controller.dispose();
    super.dispose();
  }
}