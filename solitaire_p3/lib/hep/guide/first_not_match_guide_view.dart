import 'dart:math';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';

class FirstNotMatchGuideView extends StatelessWidget{
  Function() clickCall;
  FirstNotMatchGuideView({
    required this.clickCall,
  });

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: InkWell(
      onTap: (){
        _click();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 138.h,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 45.w,right: 45.w),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      P1Image(name: "new_guide_bg",width: double.infinity,height: 138.h,),
                      Container(
                        margin: EdgeInsets.only(left: 40.w,right: 40.w,bottom: 10.h),
                        child: P1Text(text: "No playable cards! Tap here to deal a new card!", size: 14.sp, color: "#000000",showShadows: false,),
                      )
                    ],
                  ),
                ),
                P1LottieView(name: "finger",width: 72.w,height: 72.w,),
              ],
            ).marginOnly(left: 50.w),
          ],
        ),
      ),
    ),
  );

  _click(){
    GuideHep.instance.hideOverlay();
    clickCall.call();
  }
}