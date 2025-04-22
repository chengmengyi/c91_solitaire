import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_con.dart';
import 'package:solitaire_p3/view/video_btn_view.dart';

class P3GetCoinsDialog extends P1BaseStatelessDialog<P3GetCoinsCon>{
  double addNum;
   P3GetCoinsDialog({required this.addNum});

  @override
  P3GetCoinsCon initCon() => P3GetCoinsCon();

  @override
  Widget contentWidget() => Container(
    margin: EdgeInsets.only(left: 38.w,right: 38.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        P1Image(name: "get1",width: double.infinity,height: 56.h,),
        VideoBtnView(
          text: "Double",
          clickCall: (){
            p1Con.clickDou(addNum);
          },
        ),
        SizedBox(height: 8.h,),
        InkWell(
          onTap: (){
            p1Con.clickSingle(addNum);
          },
          child: P1Text(
            text: "Collect",
            size: 14.sp,
            color: "#FFFFFF",
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
          ),
        )
      ],
    ),
  );
}