import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/page/p3_level50/p3_level50_controller.dart';
import 'package:solitaire_p3/view/bottom/p3_bottom_view.dart';
import 'package:solitaire_p3/view/card_item_view.dart';
import 'package:solitaire_p3/view/coins_view.dart';
import 'package:solitaire_p3/view/set_view.dart';

class P3Level50Page extends P1BaseStatelessPage<P3Level50Controller>{
  @override
  String bgName() => "level101";

  @override
  P3Level50Controller initCon() => P3Level50Controller();

  @override
  Widget contentWidget() => Stack(
    children: [
      SafeArea(
        child: Column(
          children: [
            _topWidget(),
            SizedBox(height: 20.h,),
            _levelWidget(),
            _playWidget(),
            P3BottomView(p3play: p1Con.p3play),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
    ],
  );

  _playWidget()=>Expanded(
    child: Center(
      child: GetBuilder<P3Level50Controller>(
          id: "list",
          builder: (_){
            if(p1Con.p3play.cardList.length!=5){
              return Container();
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                _level1Widget(p1Con.p3play.cardList[0]),
                _level2Widget(p1Con.p3play.cardList[1]),
                _level3Widget(p1Con.p3play.cardList[2]),
                _level4Widget(p1Con.p3play.cardList[3]),
                _level5Widget(p1Con.p3play.cardList[4]),
              ],
            );
          }
      ),
    ),
  );

  _level1Widget(List<CardBean> list)=> Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _cardItemWidget(list[0]),
      SizedBox(height: 20.h,),
      Stack(
        children: [
          _cardItemWidget(list[1]),
          Container(
            margin: EdgeInsets.only(left: 36.w),
            child: _cardItemWidget(list[2]),
          ),
        ],
      ),
      SizedBox(height: 20.h,),
      _cardItemWidget(list[3]),
    ],
  );

  _level2Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: -30*pi/180,
            alignment: Alignment.bottomRight,
            child: _cardItemWidget(list[0]),
          ),
          SizedBox(width: 30.w,),
          Transform.rotate(
            angle: 30*pi/180,
            alignment: Alignment.bottomLeft,
            child: _cardItemWidget(list[1]),
          )
        ],
      ),
      SizedBox(height: 30.h,),
      _cardItemWidget(list[2]),
      SizedBox(height: 30.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: 30*pi/180,
            alignment: Alignment.topRight,
            child: _cardItemWidget(list[3]),
          ),
          SizedBox(width: 30.w,),
          Transform.rotate(
            angle: -30*pi/180,
            alignment: Alignment.topLeft,
            child: _cardItemWidget(list[4]),
          )
        ],
      ),
    ],
  );

  _level3Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: -50*pi/180,
            alignment: Alignment.bottomRight,
            child: _cardItemWidget(list[0]),
          ),
          SizedBox(width: 110.w,),
          Transform.rotate(
            angle: 50*pi/180,
            alignment: Alignment.bottomLeft,
            child: _cardItemWidget(list[1]),
          ),
        ],
      ),
      SizedBox(height: 94.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: 50*pi/180,
            alignment: Alignment.topRight,
            child: _cardItemWidget(list[2]),
          ),
          SizedBox(width: 110.w,),
          Transform.rotate(
            angle: -50*pi/180,
            alignment: Alignment.topLeft,
            child: _cardItemWidget(list[3]),
          ),
        ],
      ),
    ],
  );

  _level4Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20.w,top: 40.h),
            child: Transform.rotate(
              angle: -40*pi/180,
              alignment: Alignment.bottomRight,
              child: _cardItemWidget(list[0]),
            ),
          ),
          Transform.rotate(
            angle: -20*pi/180,
            alignment: Alignment.bottomRight,
            child: _cardItemWidget(list[1]),
          ),
          SizedBox(width: 20.w,),
          Transform.rotate(
            angle: 20*pi/180,
            alignment: Alignment.bottomLeft,
            child: _cardItemWidget(list[2]),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.w,top: 40.h),
            child: Transform.rotate(
              angle: 40*pi/180,
              alignment: Alignment.bottomLeft,
              child: _cardItemWidget(list[3]),
            ),
          ),
        ],
      ),
      SizedBox(height: 200.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20.w,bottom: 40.h),
            child: Transform.rotate(
              angle: 40*pi/180,
              alignment: Alignment.topRight,
              child: _cardItemWidget(list[4]),
            ),
          ),
          Transform.rotate(
            angle: 20*pi/180,
            alignment: Alignment.topRight,
            child: _cardItemWidget(list[5]),
          ),
          SizedBox(width: 20.w,),
          Transform.rotate(
            angle: -20*pi/180,
            alignment: Alignment.topLeft,
            child: _cardItemWidget(list[6]),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.w,bottom: 40.h),
            child: Transform.rotate(
              angle: -40*pi/180,
              alignment: Alignment.topLeft,
              child: _cardItemWidget(list[7]),
            ),
          ),
        ],
      ),
    ],
  );

  _level5Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w,top: 40.h),
            child: Transform.rotate(
              angle: -40*pi/180,
              alignment: Alignment.bottomRight,
              child: _cardItemWidget(list[0]),
            ),
          ),
          Transform.rotate(
            angle: -20*pi/180,
            alignment: Alignment.bottomRight,
            child: _cardItemWidget(list[1]),
          ),
          SizedBox(width: 4.w,),
          Transform.rotate(
            angle: 20*pi/180,
            alignment: Alignment.bottomLeft,
            child: _cardItemWidget(list[2]),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.w,top: 40.h),
            child: Transform.rotate(
              angle: 40*pi/180,
              alignment: Alignment.bottomLeft,
              child: _cardItemWidget(list[3]),
            ),
          ),
        ],
      ),
      SizedBox(height: 200.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w,bottom: 40.h),
            child: Transform.rotate(
              angle: 40*pi/180,
              alignment: Alignment.topRight,
              child: _cardItemWidget(list[4]),
            ),
          ),
          Transform.rotate(
            angle: 20*pi/180,
            alignment: Alignment.topRight,
            child: _cardItemWidget(list[5]),
          ),
          SizedBox(width: 4.w,),
          Transform.rotate(
            angle: -20*pi/180,
            alignment: Alignment.topLeft,
            child: _cardItemWidget(list[6]),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.w,bottom: 40.h),
            child: Transform.rotate(
              angle: -40*pi/180,
              alignment: Alignment.topLeft,
              child: _cardItemWidget(list[7]),
            ),
          ),
        ],
      ),
    ],
  );

  _cardItemWidget(CardBean bean)=> CardItemView(
    cardBean: bean,
    clickCard: (){
      p1Con.clickCard(bean);
    },
  );

  _topWidget()=>Row(
    children: [
      SizedBox(width: 18.w,),
      CoinsView(),
      const Spacer(),
      SetView(),
      SizedBox(width: 18.w,),
    ],
  );

  _levelWidget()=>SizedBox(
    width: double.infinity,
    height: 46.h,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        P1Image(name: "level102",width: double.infinity,height: 46.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            P1Text(text: "Level", size: 20.sp, color: "#FFFFFF"),
            SizedBox(width: 10.w,),
            GetBuilder<P3Level50Controller>(
              id: "level",
              builder: (_)=>P1Text(text: "${p3CurrentLevel.getData()}", size: 20.sp, color: "#6CFFF8",),
            ),
          ],
        ),
      ],
    ),
  );
}