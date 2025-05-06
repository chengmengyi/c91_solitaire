import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/page/p3_level40/p3_level40_controller.dart';
import 'package:solitaire_p3/view/bottom/p3_bottom_view.dart';
import 'package:solitaire_p3/view/card_item_view.dart';
import 'package:solitaire_p3/view/coins_view.dart';
import 'package:solitaire_p3/view/set_view.dart';

class P3Level40Page extends P1BaseStatelessPage<P3Level40Controller>{
  @override
  String bgName() => "level101";

  @override
  P3Level40Controller initCon() => P3Level40Controller();

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
      child: GetBuilder<P3Level40Controller>(
          id: "list",
          builder: (_){
            if(p1Con.p3play.cardList.length!=3){
              return Container();
            }
            return SizedBox(
              width: 330.w,
              height: 348.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _bottomWidget(p1Con.p3play.cardList.first),
                  _centerWidget(p1Con.p3play.cardList[1]),
                  _cardTopWidget(p1Con.p3play.cardList[2]),
                ],
              ),
            );
          }
      ),
    ),
  );

  _bottomWidget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[0]),
          SizedBox(width: 56.w,),
          _cardItemWidget(list[1]),
        ],
      ),
      SizedBox(height: 12.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[2]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[3]),
          SizedBox(width: 56.w,),
          _cardItemWidget(list[4]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[5]),
        ],
      ),
      SizedBox(height: 12.h,),
      _cardItemWidget(list[6]),
    ],
  );

  _centerWidget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: List.generate(4, (index){
          return Container(
            margin: EdgeInsets.only(left: index==2?118.w:(index==1||index==3)?6.w:0),
            child: _cardItemWidget(list[index]),
          );
        }),
      ),
      SizedBox(height: 12.h,),
      Row(
        children: List.generate(6, (index){
          var start = index+4;
          return Container(
            margin: EdgeInsets.only(left: start==4?0:6.w),
            child: _cardItemWidget(list[start]),
          );
        }),
      ),
      SizedBox(height: 12.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[10]),
          SizedBox(width: 6.w,),
          _cardItemWidget(list[11]),
        ],
      ),
      SizedBox(height: 12.h,),
      _cardItemWidget(list[12]),
    ],
  );

  _cardTopWidget(List<CardBean> list)=>Align(
    alignment: Alignment.topCenter,
    child: Container(
      margin: EdgeInsets.only(top: 40.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cardItemWidget(list[0]),
          SizedBox(width: 185.w,),
          _cardItemWidget(list[1]),
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
            GetBuilder<P3Level40Controller>(
              id: "level",
              builder: (_)=>P1Text(text: "${p3CurrentLevel.getData()}", size: 20.sp, color: "#6CFFF8",),
            ),
          ],
        ),
      ],
    ),
  );
}