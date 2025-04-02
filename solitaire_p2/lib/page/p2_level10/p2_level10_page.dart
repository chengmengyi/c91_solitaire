import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/page/p2_level10/p2_level_10_con.dart';
import 'package:solitaire_p2/view/bottom/p2_bottom_view.dart';
import 'package:solitaire_p2/view/coins_view.dart';
import 'package:solitaire_p2/view/longjuanfeng_view.dart';
import 'package:solitaire_p2/view/set_view.dart';
import 'package:solitaire_p2/view/wan_neng_view.dart';

class P2Level10Page extends P1BaseStatelessPage<P2Level10Con>{
  @override
  String bgName() => "level101";

  @override
  P2Level10Con initCon() => P2Level10Con();

  @override
  Widget contentWidget() => SafeArea(
    child: Column(
      children: [
        _topWidget(),
        SizedBox(height: 20.h,),
        _levelWidget(),
        _playWidget(),
        // _bottomWidget(),
        P2BottomView(p2play: p1Con.p2play),
        SizedBox(height: 20.h,),
      ],
    ),
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
            GetBuilder<P2Level10Con>(
              id: "level",
              builder: (_)=>P1Text(text: "${p2CurrentLevel.getData()}", size: 20.sp, color: "#6CFFF8",),
            ),
          ],
        ),
      ],
    ),
  );

  _playWidget()=>Expanded(
    child: Center(
      child: GetBuilder<P2Level10Con>(
        id: "list",
        builder: (_)=>p1Con.cardList.isEmpty?
        Container():
        SizedBox(
          width: 196.w,
          height: 266.h,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: List.generate(p1Con.cardList.length<5?p1Con.cardList.length:5, (index){
                  var list = p1Con.cardList[index];
                  var oushu = index%2==0;
                  return Positioned(
                    top: index*46.h,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        list.first.show?
                        _cardItemWidget(list.first):
                        SizedBox(width: 50.w,height: 78.h,),
                        SizedBox(width: oushu?96.w:26.w,),
                        list.last.show?
                        _cardItemWidget(list.last):
                        SizedBox(width: 50.w,height: 78.h,),
                      ],
                    ),
                  );
                }),
              ),
              p1Con.cardList.length==6&&p1Con.cardList.last.first.show?
              _cardItemWidget(p1Con.cardList.last.first):
              Container(),
            ],
          ),
        ),
      ),
    ),
  );

  _cardItemWidget(CardBean bean)=>SizedBox(
    key: bean.show?bean.globalKey:null,
    child: InkWell(
      onTap: (){
        p1Con.clickCard(bean);
      },
      child: P1Image(name: p1Con.getCardImageIcon(bean),width: 50.w,height: 78.h,),
    ),
  );

  _bottomWidget()=>Row(
    children: [
      SizedBox(width: 22.w,),
      InkWell(
        onTap: (){
          p1Con.changeHandCard();
        },
        child: SizedBox(
          width: 90.w,
          child: GetBuilder<P2Level10Con>(
            id: "hand_card_num",
            builder: (_){
              var length = p1Con.currentHandsNum<5?p1Con.currentHandsNum:5;
              return Stack(
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
                          child: P1Text(text: "${p1Con.currentHandsNum}", size: 14.sp, color: "#FFFFFF"),
                        ),
                      )
                    ],
                  ),
                )),
              );
            },
          ),
        ),
      ),
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: GetBuilder<P2Level10Con>(
            id: "hand_card",
            builder: (_)=>null==p1Con.currentHandCard?
            Container():
            P1Image(name: p1Con.getHandCardImageIcon(),width: 50.w,height: 78.h,),
          ),
        ),
      ),
      InkWell(
        onTap: (){
          p1Con.clickWanNeng();
        },
        child: WanNengView(),
      ),
      SizedBox(width: 12.w,),
      InkWell(
        onTap: (){
          p1Con.clickLongJuanFeng();
        },
        child: LongJuanFengView(),
      ),
      SizedBox(width: 22.w,),
    ],
  );
}