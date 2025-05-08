import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/page/p3_level30/p3_level30_controller.dart';
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

class P3Level30Page extends P1BaseStatelessPage<P3Level30Controller>{
  @override
  String bgName() => "level101";

  @override
  P3Level30Controller initCon() => P3Level30Controller();

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
      child: GetBuilder<P3Level30Controller>(
          id: "list",
          builder: (_){
            if(p1Con.p3play.cardList.length!=3){
              return Container();
            }
            return SizedBox(
              width: 260.w,
              height: 348.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _cardBottomWidget(p1Con.p3play.cardList.first),
                  _cardCenterWidget(p1Con.p3play.cardList[1]),
                  _cardTopWidget(p1Con.p3play.cardList[2]),
                ],
              ),
            );
          }
      ),
    ),
  );

  _cardBottomWidget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[0]),
          SizedBox(width: 93.w,),
          _cardItemWidget(list[1]),
        ],
      ),
      SizedBox(height: 108.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[2]),
          SizedBox(width: 93.w,),
          _cardItemWidget(list[3]),
        ],
      )
    ],
  );

  _cardCenterWidget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(4, (index){
      if(index==0||index==3){
        return Container(
          margin: EdgeInsets.only(top: index==3?12.h:0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _cardItemWidget(list[index==0?0:10]),
              SizedBox(width: 30.w,),
              _cardItemWidget(list[index==0?1:11]),
            ],
          ),
        );
      }
      var start = index*(index==1?2:3);
      return Container(
        margin: EdgeInsets.only(top: 12.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _cardItemWidget(list[start]),
            SizedBox(width: 15.w,),
            _cardItemWidget(list[start+1]),
            SizedBox(width: 30.w,),
            _cardItemWidget(list[start+2]),
            SizedBox(width: 15.w,),
            _cardItemWidget(list[start+3]),
          ],
        ),
      );
    }),
  );


  _cardTopWidget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _cardItemWidget(list.first),
      SizedBox(height: 22.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[1]),
          SizedBox(width: 20.w,),
          _cardItemWidget(list[2]),
          SizedBox(width: 20.w,),
          _cardItemWidget(list[3]),
        ],
      ),
      SizedBox(height: 22.h,),
      _cardItemWidget(list.last),
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
            GetBuilder<P3Level30Controller>(
              id: "level",
              builder: (_)=>P1Text(text: "${p3CurrentLevel.getData()}", size: 20.sp, color: "#6CFFF8",),
            ),
          ],
        ),
      ],
    ),
  );
}