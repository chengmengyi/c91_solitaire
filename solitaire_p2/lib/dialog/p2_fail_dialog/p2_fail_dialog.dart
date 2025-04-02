import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_rich_text.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/dialog/p2_fail_dialog/p2_fail_con.dart';

class P2FailDialog extends P1BaseStatelessDialog<P2FailCon>{
  @override
  P2FailCon initCon() => P2FailCon();

  @override
  Widget contentWidget() =>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 24.w,right: 24.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            P1Image(name: "fail1",width: double.infinity,height:266.h),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                P1Image(name: "fail2",width: 190.w,height: 44.h,),
                _hasMoneyWidget(),
                _btnWidget(),
              ],
            )
          ],
        ),
        Visibility(
          visible: p1Con.hasMoney,
          child: InkWell(
            onTap: (){
              p1Con.clickHome();
            },
            child: P1Text(
              text: "Home",
              size: 14.sp,
              color: "#FFFFFF",
              decoration: TextDecoration.underline,
              decorationColor: "#FFFFFF".toColor(),
            ),
          ),
        )
      ],
    ),
  );

  _hasMoneyWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      P1Image(name: "fail3",width: 100.w,height: 100.h,),
      RichText(
        text: TextSpan(
          children: [
            richText(
              text: "Spend",
              color: "#FFFFFF",
              size: 24.sp,
              shadowsColor: "#000000"
            ),
            richText(
                text: " 2000 ",
                color: "#FFF82F",
                size: 24.sp,
                shadowsColor: "#000000"
            ),
            richText(
                text: "Gold To Get",
                color: "#FFFFFF",
                size: 24.sp,
                shadowsColor: "#000000"
            ),
          ]
        ),
      ),
      RichText(
        text: TextSpan(
            children: [
              richText(
                  text: "Extra",
                  color: "#FFFFFF",
                  size: 24.sp,
                  shadowsColor: "#000000"
              ),
              richText(
                  text: " 5 ",
                  color: "#6CFFF8",
                  size: 24.sp,
                  shadowsColor: "#000000"
              ),
              richText(
                  text: "Cards!",
                  color: "#FFFFFF",
                  size: 24.sp,
                  shadowsColor: "#000000"
              ),
            ]
        ),
      ),
      SizedBox(height: 20.h,),
    ],
  );

  _btnWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: (){
          p1Con.clickLeft();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            P1Image(name: "btn_bg1",width: 140.w,height: 60.h,),
            P1Text(text: p1Con.hasMoney?"Replay":"Home", size: 24.sp, color: "#FFFFFF",shadowsColor: "#650000",)
          ],
        ),
      ),
      SizedBox(width: 20.w,),
      InkWell(
        onTap: (){
          p1Con.clickRight();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            P1Image(name: "btn_bg2",width: 140.w,height: 60.h,),
            P1Text(text: p1Con.hasMoney?"Get Cards":"Replay", size: 24.sp, color: "#FFFFFF",shadowsColor: "#650000",)
          ],
        ),
      ),
    ],
  );
}