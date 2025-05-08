import 'dart:math';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/page/p3_level60/p3_level60_controller.dart';
import 'package:solitaire_p3/view/bottom/p3_bottom_view.dart';
import 'package:solitaire_p3/view/card_item_view.dart';
import 'package:solitaire_p3/view/coins_lottie_view.dart';
import 'package:solitaire_p3/view/coins_view.dart';
import 'package:solitaire_p3/view/hand_card_remove_view.dart';
import 'package:solitaire_p3/view/longjuanfeng_lottie_view.dart';
import 'package:solitaire_p3/view/move_to_hand_card_animator_view.dart';
import 'package:solitaire_p3/view/set_view.dart';
import 'package:solitaire_p3/view/top_pro_view/top_pro_view.dart';
import 'package:solitaire_p3/view/wind_animator_view.dart';

class P3Level60Page extends P1BaseStatelessPage<P3Level60Controller>{
  @override
  String bgName() => "level101";

  @override
  P3Level60Controller initCon() => P3Level60Controller();

  @override
  Widget contentWidget() => Stack(
    children: [
      SafeArea(
        child: Column(
          children: [
            _topWidget(),
            SizedBox(height: 10.h,),
            TopProView(),
            SizedBox(height: 6.h,),
            _levelWidget(),
            _playWidget(),
            P3BottomView(p3play: p1Con.p3play),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
      LongJuanFengLottieView(),
      CoinsLottieView(),
      WindAnimatorView(),
      HandCardRemoveView(),
      MoveToHandCardAnimatorView(),
    ],
  );

  _playWidget()=>Expanded(
    child: Center(
      child: GetBuilder<P3Level60Controller>(
          id: "list",
          builder: (_){
            if(p1Con.p3play.cardList.length!=4){
              return Container();
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                _level1Widget(p1Con.p3play.cardList[0]),
                _level2Widget(p1Con.p3play.cardList[1]),
                _level3Widget(p1Con.p3play.cardList[2]),
                _level4Widget(p1Con.p3play.cardList[3]),
              ],
            );
          }
      ),
    ),
  );

  _level1Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _cardItemWidget(list[0]),
      SizedBox(height: 174.h,),
      _cardItemWidget(list[1]),
    ],
  );

  _level2Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(2, (shuIndex){
      return Container(
        margin: EdgeInsets.only(top: shuIndex==0?0:102.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (hengIndex){
            return Container(
              margin: EdgeInsets.only(left: 1.5.w,right: 1.5.w),
              child: _cardItemWidget(list[shuIndex*3+hengIndex]),
            );
          }),
        ),
      );
    }),
  );

  _level3Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(2, (shuIndex){
      return Container(
        margin: EdgeInsets.only(top: shuIndex==0?0:22.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (hengIndex){
            return Container(
              margin: EdgeInsets.only(left: 1.5.w,right: 1.5.w),
              child: _cardItemWidget(list[shuIndex*5+hengIndex]),
            );
          }),
        ),
      );
    }),
  );

  _level4Widget(List<CardBean> list)=>Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(7, (index) => Container(
      margin: EdgeInsets.only(left: 1.5.w,right: 1.5.w), child: _cardItemWidget(list[index]),
    )),
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
            GetBuilder<P3Level60Controller>(
              id: "level",
              builder: (_)=>P1Text(text: "${p3CurrentLevel.getData()}", size: 20.sp, color: "#6CFFF8",),
            ),
          ],
        ),
      ],
    ),
  );
}