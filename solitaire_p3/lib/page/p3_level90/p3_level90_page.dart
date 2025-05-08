import 'dart:math';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/page/p3_level90/p3_level90_controller.dart';
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

class P3Level90Page extends P1BaseStatelessPage<P3Level90Controller>{
  @override
  String bgName() => "level101";

  @override
  P3Level90Controller initCon() => P3Level90Controller();

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
      child: GetBuilder<P3Level90Controller>(
          id: "list",
          builder: (_){
            if(p1Con.p3play.cardList.length!=4){
              return Container();
            }
            return Stack(
              alignment: Alignment.topCenter,
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
      SizedBox(height: 40.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[0]),
          SizedBox(width: 36.w,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _cardItemWidget(list[1]),
              SizedBox(height: 6.h,),
              _cardItemWidget(list[2]),
            ],
          ),
          SizedBox(width: 36.w,),
          _cardItemWidget(list[3]),
        ],
      ),
      SizedBox(height: 66.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[4]),
          SizedBox(width: 186.h,),
          _cardItemWidget(list[5]),
        ],
      )
    ],
  );

  _level2Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(2, (shuIndex){
          return Container(
            margin: EdgeInsets.only(top: shuIndex==0?0:92.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(2, (hengIndex){
                return Container(
                  margin: EdgeInsets.only(left: 3.w,right: 3.w),
                  child: _cardItemWidget(list[shuIndex*2+hengIndex]),
                );
              }),
            ),
          );
        }),
      ),
      SizedBox(height: 36.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[4]),
          SizedBox(width: 152.h,),
          _cardItemWidget(list[5]),
        ],
      )
    ],
  );

  _level3Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 40.h,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(2, (shuIndex){
          return Container(
            margin: EdgeInsets.only(top: shuIndex==0?0:6.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(2, (hengIndex){
                return Container(
                  margin: EdgeInsets.only(left: 33.w,right: 33.w),
                  child: _cardItemWidget(list[shuIndex*2+hengIndex]),
                );
              }),
            ),
          );
        }),
      ),
      SizedBox(height: 104.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[4]),
          SizedBox(width: 120.h,),
          _cardItemWidget(list[5]),
        ],
      )
    ],
  );

  _level4Widget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[0]),
          SizedBox(width: 120.h,),
          _cardItemWidget(list[1]),
        ],
      ),
      SizedBox(height: 6.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[2]),
          SizedBox(width: 6.h,),
          _cardItemWidget(list[3]),
        ],
      ),
      SizedBox(height: 6.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[4]),
          SizedBox(width: 120.h,),
          _cardItemWidget(list[5]),
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
            GetBuilder<P3Level90Controller>(
              id: "level",
              builder: (_)=>P1Text(text: "${p3CurrentLevel.getData()}", size: 20.sp, color: "#6CFFF8",),
            ),
          ],
        ),
      ],
    ),
  );
}