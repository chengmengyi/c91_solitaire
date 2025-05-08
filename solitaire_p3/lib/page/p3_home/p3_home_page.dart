import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_rich_text.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/page/p3_home/p3_home_con.dart';
import 'package:solitaire_p3/view/coins_view.dart';
import 'package:solitaire_p3/view/set_view.dart';

class P3HomePage extends P1BaseStatelessPage<P3HomeCon>{
  @override
  String bgName() => "home1";

  @override
  P3HomeCon initCon() => P3HomeCon();

  @override
  Widget contentWidget() => SafeArea(
    child: Column(
      children: [
        _topWidget(),
        _progressWidget(),
        // SizedBox(height: 100.h,),
        P1LottieView(name: "home", width: 250.w,height: 250.h,),
        SizedBox(height: 20.h,),
        _levelWidget(),
        SizedBox(height: 20.h,),
        _playWidget(),
        SizedBox(height: 60.h,),
      ],
    ),
  );

  _progressWidget()=>Container(
    width: double.infinity,
    height: 91.h,
    margin: EdgeInsets.only(left: 16.w,right: 16.w),
    child: Stack(
      children: [
        P1Image(name: "home11",width: double.infinity,height: double.infinity,),
        GetBuilder<P3HomeCon>(
          id: "progress",
          builder: (_)=>Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  P1Image(name: "home9",width: 66.w,height: 66.h,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          children: p3Coins.getData()<200?
                          [
                            richText(text: "Games to Claim ", color: "#4C0000", size: 15.sp,showShadows: false,),
                            richText(text: "\$200", color: "#149900", size: 15.sp,showShadows: false,),
                            richText(text: "!Play Now, Cash Out Today!", color: "#4C0000", size: 15.sp,showShadows: false,),
                          ]:
                          [
                            richText(text: "\$200", color: "#149900", size: 15.sp,showShadows: false,),
                            richText(text: " Ready !Withdraw Instantly!", color: "#4C0000", size: 15.sp,showShadows: false,),
                          ]
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      p1Con.clickCash();
                    },
                    child: P1Image(name: p3Coins.getData()<200?"home10":"home12",width: 70.w,height: 33.h,),
                  ),
                  SizedBox(width: 16.w,),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 16.w,right: 16.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: "#6A4321".toColor(),
                            borderRadius: BorderRadius.circular(50.w),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2.w,right: 2.w),
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: p1Con.getProgress(),
                              child: P1Image(name: "launch3",width: double.infinity,height: 10.h,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    P1Text(text: "100%", size: 12.sp, color: "#FFFFFF")
                  ],
                ),
              )
            ],
          ),
        ),
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

  _playWidget()=> Row(
    children: [
      SizedBox(width: 18.w,),
      // InkWell(
      //   child: P1Image(name: "home6",width: 75.w,height: 75.h,),
      // ),
      SizedBox(width: 75.w,height: 75.h,),
      Expanded(
        child: InkWell(
          onTap: (){
            p1Con.clickPlay();
          },
          child: SizedBox(
            key: p1Con.playGlobalKey,
            child: P1Image(name: "home7",width: double.infinity,height: 70.h,),
          ),
        ),
      ),
      InkWell(
        onTap: (){
          p1Con.clickCash();
        },
        child: P1Image(name: "home8",width: 75.w,height: 75.h,),
      ),
      SizedBox(width: 18.w,),
    ],
  );

  _levelWidget()=>GetBuilder<P3HomeCon>(
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