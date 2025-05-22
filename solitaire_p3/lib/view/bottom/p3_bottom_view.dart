import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/dialog/p3_buy_long_juan_card_dialog/p3_buy_long_juan_card_dialog.dart';
import 'package:solitaire_p3/dialog/p3_buy_wan_neng_card_dialog/p3_buy_wan_neng_card_dialog.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';
import 'package:solitaire_p3/hep/guide/longjuanfeng_guide_view.dart';
import 'package:solitaire_p3/hep/guide/wanneng_guide_view.dart';
import 'package:solitaire_p3/hep/p3_play.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';
import 'package:solitaire_p3/view/longjuanfeng_view.dart';
import 'package:solitaire_p3/view/wan_neng_view.dart';

class P3BottomView extends StatefulWidget{
  P3Play p3play;
  P3BottomView({required this.p3play});

  @override
  State<StatefulWidget> createState() => P3BottomViewState();
}
class P3BottomViewState extends State<P3BottomView> with TickerProviderStateMixin{
  var showBackHandCard=false,isFront = true,canClickLeftCard=true;
  Offset? endOffset,startOffset;
  GlobalKey longjuanfengGlobalKey=GlobalKey();
  GlobalKey wannengGlobalKey=GlobalKey();
  GlobalKey handCardGlobalKey=GlobalKey();
  GlobalKey backHandCardGlobalKey=GlobalKey();
  Animation<Offset>? keyAnimation;
  late AnimationController _animationController;

  late AnimationController _handCardController;
  late Animation<double> handCardAnimation;
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.updateHandCard:
          setState(() {});
          break;
        case P3EventCode.getFiveCards:
          widget.p3play.getFiveCards(
              call: (){
                setState(() {});
              }
          );
          break;
        case P3EventCode.removeHandCard:
          _removeHandCard();
          break;
        case P3EventCode.showLongjuanfengGuide:
          _showLongjuanfengGuide();
          break;
      }
    });
    _initAnimator();
    Future((){
      _getHandCardOffset();
    });
  }


  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(left: 22.w,right: 22.w),
    child: Stack(
      children: [
        Row(
          children: [
            _leftHandCardWidget(),
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: SizedBox(
                    key: handCardGlobalKey,
                    child: null==widget.p3play.currentHandCard?
                    SizedBox(width: 50.w,height: 78.h,):
                    AnimatedBuilder(
                      animation: handCardAnimation,
                      builder: (context, child) {
                        final angle = handCardAnimation.value * 3.1415926;
                        final transform = Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle);
                        return Transform(
                          transform: transform,
                          alignment: Alignment.center,
                          child: Opacity(
                            opacity: angle <= 3.1415926 / 2 ? 1 : 0,
                            child: isFront ?
                            P1Image(name: widget.p3play.getHandCardImageIcon(),width: 50.w,height: 78.h,) :
                            Transform(
                              transform: Matrix4.identity()..rotateY(3.1415926),
                              alignment: Alignment.center,
                              child: P1Image(name: "card_back",width: 50.w,height: 78.h,),
                            ),
                          ),
                        );
                      },
                    )
                ),
              ),
            ),
            InkWell(
              onTap: (){
                clickWanNeng();
              },
              child: SizedBox(
                key: wannengGlobalKey,
                child: WanNengView(),
              ),
            ),
            SizedBox(width: 12.w,),
            InkWell(
              onTap: (){
                clickLongJuanFeng();
              },
              child: SizedBox(
                key: longjuanfengGlobalKey,
                child: LongJuanFengView(),
              ),
            ),
          ],
        ),
        _backHandCardWidget(),
      ],
    ),
  );

  _leftHandCardWidget(){
    var length = widget.p3play.currentHandsNum<5?widget.p3play.currentHandsNum:5;
    return InkWell(
      onTap: (){
        changeHandCard();
      },
      child: SizedBox(
        width: 90.w,
        child: Stack(
          children: List.generate(length, (index) => Container(
            margin: EdgeInsets.only(left: (10.w)*index),
            child: Stack(
              alignment: Alignment.bottomCenter ,
              children: [
                P1Image(name: "card_back",width: 50.w,height: 78.h,),
                Visibility(
                  visible: length==index+1,
                  child: Container(
                    width: 42.w,
                    height: 14.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: "#000000".toColor().withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.w)
                    ),
                    child: P1Text(text: "${widget.p3play.currentHandsNum}", size: 14.sp, color: "#FFFFFF"),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  _backHandCardWidget(){
    var value = keyAnimation?.value;
    var dx = (value?.dx??0)-22.w;
    return SizedBox(
      key: backHandCardGlobalKey,
      child: Visibility(
        visible: showBackHandCard,
        child: Container(
          margin: EdgeInsets.only(left: dx<=0?0:dx),
          child: P1Image(name: "card_back",width: 50.w,height: 78.h,),
        ),
      ),
    );
  }

  clickWanNeng({fromGuide=false}){
    if(!widget.p3play.canClick){
      return;
    }
    if(fromGuide){
      widget.p3play.hasWanNengCard();
      setState(() {});
      p3ShowedLongJuanFengGuide.saveData(true);
      return;
    }
    P1RouterFun.showDialog(
      w: P3BuyWanNengCardDialog(
        hasWanNengCall: (){
          widget.p3play.hasWanNengCard();
          setState(() {});
        },
      ),
    );
  }

  clickLongJuanFeng({fromGuide=false}){
    if(!widget.p3play.canClick){
      return;
    }
    if(fromGuide){
      _useLongJuanFeng(fromGuide: fromGuide);
      return;
    }
    P1RouterFun.showDialog(
      w: P2BuyLongJuanDialog(
        hasLongJuanCall: (){
          _useLongJuanFeng();
        },
      ),
    );
  }

  _useLongJuanFeng({fromGuide=false}){
    CashTaskHep.instance.updateCashTask(CashTask.longjuanfeng);
    List<CardBean> list=[];
    for (var value in widget.p3play.cardList) {
      for (var value1 in value) {
        if(value1.show&&!value1.covered&&value1.cardNum!="-1"){
          list.add(value1);
        }
      }
    }
    P1EventBean(code: P3EventCode.showLongJuanFengLottie,anyValue: list).send();
    if(fromGuide){
      Future.delayed(const Duration(milliseconds: 1000),(){
        _showWannengGuide();
      },);
    }
  }

  changeHandCard()async{
    if(!widget.p3play.canClick||!canClickLeftCard){
      return;
    }
    canClickLeftCard=false;
    showBackHandCard=true;
    var dx = startOffset?.dx??0;
    if(widget.p3play.currentHandsNum>=5){
      dx+=(50.w);
    }else{
      dx+=(10.w)*widget.p3play.currentHandsNum;
    }
    var offset=Offset(dx, startOffset?.dy??0);

    keyAnimation=Tween<Offset>(
      begin: offset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    setState(() {});
    _animationController..reset()..forward();
    await Future.delayed(const Duration(milliseconds: 300));
    isFront=false;
    setState(() {});
    _handCardController..reset()..forward();
    await Future.delayed(const Duration(milliseconds: 500));
    widget.p3play.changeHandCard((){
      canClickLeftCard=true;
      setState(() {});
      widget.p3play.checkShowGuideStep3(context);
    });
  }

  _showLongjuanfengGuide(){
    PointHep.instance.point(pointEvent: PointEvent.newuser_guide,params: {"pop_step":"pop10"});
    var renderBox = longjuanfengGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    GuideHep.instance.showOverlay(
      context: context,
      widget: LongJuanFengGuideView(
        offset: offset,
        clickCall: (){
          clickLongJuanFeng(fromGuide: true);
        },
      ),
    );
  }

  _showWannengGuide(){
    PointHep.instance.point(pointEvent: PointEvent.newuser_guide,params: {"pop_step":"pop11"});
    var renderBox = wannengGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    GuideHep.instance.showOverlay(
      context: context,
      widget: WannengGuideView(
        offset: offset,
        clickCall: (){
          clickWanNeng(fromGuide: true);
        },
      ),
    );
  }

  _removeHandCard()async{
    if(widget.p3play.currentHandsNum<=0){
      return;
    }
    widget.p3play.canClick=false;
    while(widget.p3play.currentHandsNum>0){
      widget.p3play.removeHandCard();
      setState(() {});
      P1Mp3Hep.instance.playXiaoChu();
      P3UserInfoHep.instance.updateUserCoins(P3ValueHep.instance.getCardAddNum(),removeHandCard: true);
      await Future.delayed(const Duration(milliseconds: 400));
    }
    widget.p3play.canClick=true;
    widget.p3play.showWinnerDialog();
  }

  _getHandCardOffset(){
    var startRenderBox = backHandCardGlobalKey.currentContext!.findRenderObject() as RenderBox;
    startOffset = startRenderBox.localToGlobal(Offset.zero);
    var renderBox = handCardGlobalKey.currentContext!.findRenderObject() as RenderBox;
    endOffset = renderBox.localToGlobal(Offset.zero);
    widget.p3play.setHandCardOffset(endOffset!);
  }

  _initAnimator(){
    _handCardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    handCardAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _handCardController,
        curve: Curves.easeInOut,
      ),
    );
    _handCardController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isFront=true;
        _handCardController.reverse();
      }
    });

    _animationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          showBackHandCard=false;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _handCardController.dispose();
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}