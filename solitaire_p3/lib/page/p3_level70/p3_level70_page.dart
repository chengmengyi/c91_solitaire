import 'dart:math';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/page/p3_level70/p3_level70_controller.dart';
import 'package:solitaire_p3/view/bottom/p3_bottom_view.dart';
import 'package:solitaire_p3/view/card_item_view.dart';
import 'package:solitaire_p3/view/coins_view.dart';
import 'package:solitaire_p3/view/set_view.dart';

class P3Level70Page extends P1BaseStatelessPage<P3Level70Controller>{
  @override
  String bgName() => "level101";

  @override
  P3Level70Controller initCon() => P3Level70Controller();

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
      child: GetBuilder<P3Level70Controller>(
          id: "list",
          builder: (_){
            if(p1Con.p3play.cardList.length!=3){
              return Container();
            }
            return SizedBox(
              width: 358.w,
              height: 420.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _level1Widget(p1Con.p3play.cardList[0]),
                  _level2Widget(p1Con.p3play.cardList[1]),
                ],
              ),
            );
          }
      ),
    ),
  );

  _level1Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[0]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[1]),
          SizedBox(width: 20.w,),
          _cardItemWidget(list[2]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[3]),
          SizedBox(width: 20.w,),
          _cardItemWidget(list[4]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[5]),
        ],
      ),
      SizedBox(height: 6.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[6]),
          SizedBox(width: 258.w,),
          _cardItemWidget(list[7]),
        ],
      ),
      SizedBox(height: 96.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[8]),
          SizedBox(width: 258.w,),
          _cardItemWidget(list[9]),
        ],
      ),
      SizedBox(height: 6.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[10]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[11]),
          SizedBox(width: 20.w,),
          _cardItemWidget(list[12]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[13]),
          SizedBox(width: 20.w,),
          _cardItemWidget(list[14]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[15]),
        ],
      ),
    ],
  );

  _level2Widget(List<CardBean> list)=>Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: EdgeInsets.only(bottom: 108.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: -30*pi/180,
            // angle: 0,
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _cardItemWidget(list[0]),
                SizedBox(height: 6.h,),
                _cardItemWidget(list[1]),
                SizedBox(height: 6.h,),
                _cardItemWidget(list[2]),
              ],
            ),
          ),
          SizedBox(width: 6.w,),
          Transform.rotate(
            angle: 30*pi/180,
            // angle: 0,
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _cardItemWidget(list[3]),
                SizedBox(height: 6.h,),
                _cardItemWidget(list[4]),
                SizedBox(height: 6.h,),
                _cardItemWidget(list[5]),
              ],
            ),
          ),
        ],
      ),
    ),
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
            GetBuilder<P3Level70Controller>(
              id: "level",
              builder: (_)=>P1Text(text: "${p3CurrentLevel.getData()}", size: 20.sp, color: "#6CFFF8",),
            ),
          ],
        ),
      ],
    ),
  );
}