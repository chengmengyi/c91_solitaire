import 'dart:math';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';

class Step7View extends StatelessWidget{
  Offset offset;
  Function() clickCall;
  Step7View({
    required this.offset,
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
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: offset.dy,left: 15.w,right: 15.w,),
              child: Container(
                width: double.infinity,
                height: 117.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: "#FFFFFF".toColor(),
                  borderRadius: BorderRadius.circular(15.w),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8.h,
                      left: 12.w,
                      child: P1Image(name: "cash5",height: 30.h,),
                    ),
                    Align(
                      child: P1Text(text: "\$200", size: 38.sp, color: "#D66400",showShadows: false,),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 138.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 16.h,left: 45.w,right: 45.w),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    P1Image(name: "new_guide_bg",width: double.infinity,height: 138.h,),
                    Container(
                      margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 10.h),
                      child: P1Text(text: "Sophia’s rule: Always cash out at \$200! Perfect for a weekend dinner out. How much will you grab?", size: 14.sp, color: "#000000",showShadows: false,),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10.w,
              top: offset.dy+80.h,
              child: P1LottieView(name: "finger",width: 72.w,height: 72.w,),
            )
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