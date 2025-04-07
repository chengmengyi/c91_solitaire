import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/hep/hep.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/page/p2_level20/p2_level20_con.dart';
import 'package:solitaire_p2/view/bottom/p2_bottom_view.dart';
import 'package:solitaire_p2/view/card_item_view.dart';
import 'package:solitaire_p2/view/coins_view.dart';
import 'package:solitaire_p2/view/set_view.dart';
import 'package:solitaire_p2/view/test.dart';
import 'package:solitaire_p2/view/wind_animator_view.dart';

class P2Level20Page extends P1BaseStatelessPage<P2Level20Con>{
  @override
  String bgName() => "level101";

  @override
  P2Level20Con initCon() => P2Level20Con();

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
            P2BottomView(p2play: p1Con.p2play),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
      WindAnimatorView(),
    ],
  );

  _playWidget()=>Expanded(
    child: Center(
      child: GetBuilder<P2Level20Con>(
        id: "list",
        builder: (_){
          if(p1Con.p2play.cardList.isEmpty){
            return Container();
          }
          return SizedBox(
            width: 238.w,
            height: 258.h,
            child: Stack(
              children: [
                _playBottomCardWidget(p1Con.p2play.cardList.first),
                _playTopCardWidget(p1Con.p2play.cardList.last),
              ],
            ),
          );
        }
      ),
    ),
  );

  _playTopCardWidget(List<CardBean> list)=>Stack(
    children: [
      Positioned(
        top: 43.h,
        left: 27.w,
        child: _cardItemWidget(list.first),
      ),
      Positioned(
        top: 43.h,
        right: 27.w,
        child: _cardItemWidget(list[1]),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 50.h),
          child: _cardItemWidget(list[2]),
        ),
      ),
    ],
  );

  _playBottomCardWidget(List<CardBean> list)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(3, (index){
      if(index==2){
        return Container(
          margin: EdgeInsets.only(top: 12.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _cardItemWidget(list[8]),
              SizedBox(width: 26.w,),
              _cardItemWidget(list[9]),
            ],
          ),
        );
      }
      var start = index*4;
      return Container(
        margin: EdgeInsets.only(bottom: index==0?12.h:0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _cardItemWidget(list[start]),
            SizedBox(width: 6.w,),
            _cardItemWidget(list[start+1]),
            SizedBox(width: 26.w,),
            _cardItemWidget(list[start+2]),
            SizedBox(width: 6.w,),
            _cardItemWidget(list[start+3]),
          ],
        ),
      );
    }),
  );


  _cardItemWidget(CardBean bean)=> CardItemView(
    cardBean: bean,
    clickCard: (){
      p1Con.clickCard(bean);
    },
  );
  //     bean.show?
  // SizedBox(
  //   key: bean.show?bean.globalKey:null,
  //   child: InkWell(
  //     onTap: (){
  //       p1Con.clickCard(bean);
  //     },
  //     child: P1Image(name: getCardImageIcon(bean),width: 50.w,height: 78.h,),
  //   ),
  // ):
  // SizedBox(width: 50.w,height: 78.h,);

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
            GetBuilder<P2Level20Con>(
              id: "level",
              builder: (_)=>P1Text(text: "${p2CurrentLevel.getData()}", size: 20.sp, color: "#6CFFF8",),
            ),
          ],
        ),
      ],
    ),
  );
}