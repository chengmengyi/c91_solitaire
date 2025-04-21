import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/dialog/p3_winner_dialog/p3_winner_con.dart';

class P3WinnerDialog extends P1BaseStatelessDialog<P3WinnerCon>{
  Function() close;
  Function() next;
  P3WinnerDialog({
    required this.close,
    required this.next,
});

  @override
  P3WinnerCon initCon() => P3WinnerCon();

  @override
  Widget contentWidget() =>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 24.w,right: 24.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        P1Image(name: "winner1",width: double.infinity,height:250.h),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            P1Image(name: "winner2",width: 190.w,height: 48.h,),
            SizedBox(height: 30.h,),
            _coinsWidget(),
            SizedBox(height: 30.h,),
            _btnWidget(),
          ],
        )
      ],
    ),
  );

  _coinsWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          P1Image(name: "winner3",width: 98.w,height: 98.h,),
          P1Image(name: "winner4",width: 50.w,height: 50.h,),
        ],
      ),
      P1Text(text: "+2000", size: 40.sp, color: "#FFFFFF",shadowsColor: "#650000",)
    ],
  );

  _btnWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: (){
          P1RouterFun.closePage();
          close.call();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            P1Image(name: "btn_bg1",width: 140.w,height: 60.h,),
            P1Text(text: "Home", size: 24.sp, color: "#FFFFFF",shadowsColor: "#650000",)
          ],
        ),
      ),
      SizedBox(width: 20.w,),
      InkWell(
        onTap: (){
          P1RouterFun.closePage();
          next.call();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            P1Image(name: "btn_bg2",width: 140.w,height: 60.h,),
            P1Text(text: "Next", size: 24.sp, color: "#FFFFFF",shadowsColor: "#650000",)
          ],
        ),
      ),
    ],
  );
}