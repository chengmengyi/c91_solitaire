import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';
import 'package:solitaire_p3/hep/hep.dart';
import 'package:solitaire_p3/view/coins_view.dart';

class Step5View extends StatelessWidget{
  Function() clickCall;
  Step5View({
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
            Positioned(
              left: 18.w,
              child: SafeArea(
                child: CoinsView(canClick: false,),
              ),
            ),
            Positioned(
              top: 20.h,
              left: 140.w,
              child: SafeArea(
                child: P1LottieView(name: "finger",width: 72.w,height: 72.w,),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 138.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 30.h,left: 45.w,right: 45.w),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    P1Image(name: "new_guide_bg",width: double.infinity,height: 138.h,),
                    Container(
                      margin: EdgeInsets.only(left: 40.w,right: 40.w,bottom: 10.h),
                      child: P1Text(text: "Don't Wait - Cash Out Now! 100% Guaranteed!", size: 14.sp, color: "#000000",showShadows: false,),
                    )
                  ],
                ),
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