import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/page/p2_home/p2_home_con.dart';
import 'package:solitaire_p2/view/coins_view.dart';
import 'package:solitaire_p2/view/set_view.dart';

class P2HomePage extends P1BaseStatelessPage<P2HomeCon>{
  @override
  String bgName() => "home1";

  @override
  P2HomeCon initCon() => P2HomeCon();

  @override
  Widget contentWidget() => SafeArea(
    child: Column(
      children: [
        _topWidget(),
        SizedBox(height: 100.h,),
        P1LottieView(name: "home", width: 250.w,height: 250.h,),
        SizedBox(height: 20.h,),
        _levelWidget(),
        SizedBox(height: 20.h,),
        _playWidget(),
        SizedBox(height: 60.h,),
      ],
    ),
  );

  _topWidget()=>Row(
    children: [
      SizedBox(width: 18.w,),
      CoinsView(),
      const Spacer(),
      SetView(isHome: true,),
      SizedBox(width: 18.w,),
    ],
  );

  _playWidget()=> InkWell(
    onTap: (){
      p1Con.clickPlay();
    },
    child: P1Image(name: "home2",width: 186.w,height: 70.h,),
  );

  _levelWidget()=>GetBuilder<P2HomeCon>(
    id: "level",
    builder: (_)=>Stack(
      alignment: Alignment.centerLeft,
      children: [
        Row(
          children: [
            Expanded(
              child: _lineWidget(p1Con.currentLevel>1),
            ),
            _lineWidget(true),
            Expanded(
              child: _lineWidget(true),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: _leftLevelWidget()),
            _centerLevelWidget(),
            Expanded(child: _rightLevelWidget()),
          ],
        )
      ],
    ),
  );

  _lineWidget(bool showColor)=>Container(
    height: 8.h,
    decoration: showColor?BoxDecoration(
      border: Border.all(
        width: 1.w,
        color: "#000000".toColor(),
      ),
      color: "#5D385F".toColor(),
    ):null,
  );

  _leftLevelWidget()=>p1Con.currentLevel<=1?
  Container():
  Container(
    width: double.infinity,
    alignment: Alignment.center,
    child: Stack(
      alignment: Alignment.center,
      children: [
        P1Image(name: "home3",width: 66.w,height: 66.h,),
        P1Text(text: "${p1Con.currentLevel-1}", size: 24.sp, color: "#EDE6D5",shadowsColor: "#A8A18F",),
      ],
    ),
  );

  _centerLevelWidget()=>InkWell(
    onTap: (){
      p1Con.clickTest();
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        P1Image(name: "home5",width: 142.w,height: 142.w,),
        P1Text(text: "${p1Con.currentLevel}", size: 30.sp, color: "#FFFFFF"),
      ],
    ),
  );

  _rightLevelWidget()=>Container(
    width: double.infinity,
    alignment: Alignment.center,
    child: Stack(
      alignment: Alignment.center,
      children: [
        P1Image(name: "home4",width: 66.w,height: 66.h,),
        P1Text(text: "${p1Con.currentLevel+1}", size: 24.sp, color: "#FFFFFF"),
      ],
    ),
  );
}