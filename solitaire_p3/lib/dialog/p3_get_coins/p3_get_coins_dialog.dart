import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_con.dart';
import 'package:solitaire_p3/view/scale_coins_icon_view.dart';
import 'package:solitaire_p3/view/video_btn_view.dart';

enum GetCoinsEnum{
  wheel,card,cash_card,pop,other,
}

class P3GetCoinsDialog extends P1BaseStatelessDialog<P3GetCoinsCon>{
  double addNum;
  GetCoinsEnum getCoinsEnum;
  P3GetCoinsDialog({required this.addNum,required this.getCoinsEnum});

  @override
  P3GetCoinsCon initCon() => P3GetCoinsCon();

  @override
  initView() {
    p1Con.getCoinsEnum=getCoinsEnum;
  }

  @override
  Widget contentWidget() => Container(
    margin: EdgeInsets.only(left: 38.w,right: 38.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                p1Con.clickClose();
              },
              child: P1Image(name: "icon_close",width: 30.w,height: 30.w,),
            )
          ],
        ),
        SizedBox(height: 12.h,),
        P1Image(name: "get1",width: double.infinity,height: 56.h,),
        SizedBox(height: 8.h,),
        SizedBox(
          width: 230.w,
          height: 230.h,
          child: Stack(
            children: [
              P1Image(name: "buy2",width: 230.w,height: 230.h,),
              Align(
                alignment: Alignment.center,
                child: ScaleCoinsIconView(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 18.h),
                  child: P1Text(text: "+$addNum", size: 20.sp, color: "#00F108",showShadows: false,),
                ),
              )
            ],
          ),
        ),
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