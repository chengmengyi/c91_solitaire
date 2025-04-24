import 'dart:math';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';

class Step6View extends StatelessWidget{
  Offset offset;
  double width;
  Function() clickCall;
  Step6View({
    required this.offset,
    required this.width,
    required this.clickCall,
  });

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy,
              child: InkWell(
                onTap: (){
                  _click();
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  width: width,
                  height: 57.h,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: "#FFFFFF".toColor(),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            gradient: LinearGradient(
                                colors: ["#B1FFE2".toColor(),"#C3FED9".toColor(),]
                            )
                        ),
                      ),
                      P1Image(name: "cash5",width: 100.w,height: 30.h,)
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 138.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 100.h,left: 45.w,right: 45.w),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    P1Image(name: "new_guide_bg",width: double.infinity,height: 138.h,),
                    Container(
                      margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 10.h),
                      child: P1Text(text: "Sophia here! I always cash out to PayPal – instant & safe. Pick your favorite way to get paid!", size: 14.sp, color: "#000000",showShadows: false,),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: offset.dx+width-30.w,
              top: offset.dy+30.h,
              child: InkWell(
                onTap: (){
                  _click();
                },
                child: P1LottieView(name: "finger",width: 72.w,height: 72.w,),
              ),
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