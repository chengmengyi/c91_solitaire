import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/page/p2_level10/p2_level_10_con.dart';
import 'package:solitaire_p2/view/bottom/p2_bottom_view.dart';
import 'package:solitaire_p2/view/card_item_view.dart';
import 'package:solitaire_p2/view/coins_lottie_view.dart';
import 'package:solitaire_p2/view/coins_view.dart';
import 'package:solitaire_p2/view/longjuanfeng_lottie_view.dart';
import 'package:solitaire_p2/view/set_view.dart';
import 'package:solitaire_p2/view/wind_animator_view.dart';

class P2Level10Page extends P1BaseStatelessPage<P2Level10Con>{
  @override
  String bgName() => "level101";

  @override
  P2Level10Con initCon() => P2Level10Con();

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
      LongJuanFengLottieView(),
      CoinsLottieView(),
      WindAnimatorView(),
    ],
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

  _levelWidget()=>InkWell(
    onTap: (){
      p1Con.clickTest();
    },
    child: SizedBox(
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
    ),
  );

  _playWidget()=>Expanded(
    child: Center(
      child: GetBuilder<P2Level10Con>(
        id: "list",
        builder: (_)=>p1Con.p2play.cardList.isEmpty?
        Container():
        SizedBox(
          width: 196.w,
          height: 266.h,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: List.generate(p1Con.p2play.cardList.length<5?p1Con.p2play.cardList.length:5, (index){
                  var list = p1Con.p2play.cardList[index];
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
              p1Con.p2play.cardList.length==6&&p1Con.p2play.cardList.last.first.show?
              _cardItemWidget(p1Con.p2play.cardList.last.first):
              Container(),
            ],
          ),
        ),
      ),
    ),
  );

  _cardItemWidget(CardBean bean) => CardItemView(
    cardBean: bean,
    clickCard: (){
      p1Con.clickCard(bean);
    },
  );
  //     SizedBox(
  //   key: bean.show?bean.globalKey:null,
  //   child: InkWell(
  //     onTap: (){
  //       p1Con.clickCard(bean);
  //     },
  //     child: P1Image(name: getCardImageIcon(bean),width: 50.w,height: 78.h,),
  //   ),
  // );
}