import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/dialog/p2_buy_wan_neng_card_dialog/p2_buy_wan_neng_card_con.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';

class P2BuyWanNengCardDialog extends P1BaseStatelessDialog<P2BuyWanNengCardCon>{
  Function() hasWanNengCall;
  P2BuyWanNengCardDialog({required this.hasWanNengCall});

  @override
  P2BuyWanNengCardCon initCon() => P2BuyWanNengCardCon();

  @override
  Widget contentWidget() =>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 44.w,right: 44.w),
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
        P1Image(name: "buy1",width: double.infinity,height: 62.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            P1Image(name: "buy2",width: 230.w,height: 230.h,),
            P1Image(name: "buy3",width: 140.w,height: 140.h,),
          ],
        ),
        SizedBox(height: 12.h,),
        InkWell(
          onTap: (){
            p1Con.clickCoins(hasWanNengCall);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              P1Image(name: "btn_bg3",width: 180.w,height: 60.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  P1Image(name: "coins2",width: 30.w,height: 30.h,),
                  SizedBox(width: 6.w,),
                  ShakeAnimationWidget(
                    shakeAnimationController: p1Con.shakeAnimationController,
                    shakeAnimationType: ShakeAnimationType.LeftRightShake,
                    isForward: false,
                    shakeCount: 1,
                    shakeRange: 0.2,
                    child: P1Text(text: "2000", size: 26.sp, color: p2Coins.getData()>=2000?"#FFFFFF":"#C13336",shadowsColor: "#000000",),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 12.h,),
        InkWell(
          onTap: (){
            p1Con.clickVideo(hasWanNengCall);
          },
          child: SizedBox(
            width: 180.w,
            height: 60.h,
            child: Stack(
              children: [
                P1Image(name: "btn_bg4",width: 180.w,height: 60.h,),
                Align(
                  alignment: Alignment.center,
                  child: P1Text(text: "Collect", size: 26.sp, color: "#FFFFFF",shadowsColor: "#303E10",),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: P1Image(name: "buy4",width: 30.w,height: 25.h,),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}