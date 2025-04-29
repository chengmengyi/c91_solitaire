import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_base/p3_ad_load_fail/ad_load_fail_con.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';

class AdLoadFailDialog extends P1BaseStatelessDialog<AdLoadFailCon>{
  Function() tryAgain;
  AdLoadFailDialog({
    required this.tryAgain,
});

  @override
  AdLoadFailCon initCon() => AdLoadFailCon();

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
            P1Image(name: "ad_fail2",width: 190.w,height: 44.h,),
            SizedBox(height: 30.h,),
            P1Image(name: "ad_fail3",width: 72.w,height: 72.w,),
            P1Text(text: "More Cash Coming!", size: 24.sp, color: "#FFFFFF"),
            SizedBox(height: 30.h,),
            InkWell(
              onTap: (){
                p1Con.clickTry(tryAgain);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  P1Image(name: "btn_bg2",width: 140.w,height: 60.h,),
                  P1Text(text: "Try Again", size: 24.sp, color: "#FFFFFF",shadowsColor: "#650000",)
                ],
              ),
            ),
          ],
        ),  Positioned(
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