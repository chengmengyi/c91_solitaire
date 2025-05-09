import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';
import 'package:solitaire_p3/dialog/p3_net_dialog/p3_net_con.dart';

class P3NetDialog extends P1BaseStatelessDialog<P3NetCon>{
  GetCoinsEnum getCoinsEnum;
  P3NetDialog({
    required this.getCoinsEnum,
  });

  @override
  P3NetCon initCon() => P3NetCon();

  @override
  initView() {
    p1Con.getCoinsEnum=getCoinsEnum;
  }

  @override
  Widget contentWidget() =>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 24.w,right: 24.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        P1Image(name: "ad_fail1",width: double.infinity,height:250.h),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            P1Image(name: "net1",width: 190.w,height: 44.h,),
            SizedBox(height: 30.h,),
            P1Image(name: "net2",width: 72.w,height: 72.w,),
            Container(
              margin: EdgeInsets.only(left: 26.w,right: 26.w,),
              child: P1Text(text: "Connect, and you can earn more.", size: 24.sp, color: "#FFFFFF",textAlign: TextAlign.center,),
            ),
            SizedBox(height: 30.h,),
            InkWell(
              onTap: (){
                p1Con.clickGot();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  P1Image(name: "btn_bg2",width: 140.w,height: 60.h,),
                  P1Text(text: "Got It", size: 24.sp, color: "#FFFFFF",shadowsColor: "#650000",)
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 16.h,
          right: 26.w,
          child: InkWell(
            onTap: (){
              p1Con.clickClose();
            },
            child: P1Image(name: "icon_close",width: 30.w,height: 30.h,),
          ),
        )

      ],
    ),
  );
}