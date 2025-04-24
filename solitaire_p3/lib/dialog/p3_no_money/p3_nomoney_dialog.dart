import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/dialog/p3_no_money/p3_nomoney_con.dart';

class P3NoMoneyDialog extends P1BaseStatelessDialog<P3NoMoneyCon>{

  Function() clickNow;
  P3NoMoneyDialog({required this.clickNow});

  @override
  P3NoMoneyCon initCon() => P3NoMoneyCon();

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    padding: EdgeInsets.only(left: 10.w,right: 10.w),
    margin: EdgeInsets.only(left: 32.w,right: 32.w),
    decoration: BoxDecoration(
      color: "#F7F0E1".toColor(),
      borderRadius: BorderRadius.circular(14.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.h,),
        P1Text(text: "Not enough to withdraw yet", size: 17.sp, color: "#000000",useFontFamily: false,showShadows: false,fontWeight: FontWeight.bold,),
        P1Text(text: "Play Now & Instantly Win UP TO \$200!Top up easily and withdraw instantly!", size: 14.sp, color: "#666666",useFontFamily: false,showShadows: false,),
        SizedBox(height: 34.h,),
        InkWell(
          onTap: (){
            P1RouterFun.closePage();
            clickNow.call();
          },
          child: Container(
            width: 180.w,
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: "#4283EC".toColor(),
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: P1Text(text: "Play now", size: 14.sp, color: "#FFFFFF",showShadows: false,useFontFamily: false,fontWeight: FontWeight.bold,),
          ),
        ),
        SizedBox(height: 24.h,),
      ],
    ),
  );
}