import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';
import 'package:solitaire_p3/hep/hep.dart';

class Step3View extends StatelessWidget{
  Offset offset;
  CardBean cardBean;
  Function() clickCall;
  Step3View({
    required this.offset,
    required this.cardBean,
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
              left: offset.dx,
              top: offset.dy,
              child: P1Image(name: getCardImageIcon(cardBean),width: 50.w,height: 78.h,),
            ),
            Positioned(
              top: offset.dy+50.h,
              left: offset.dx+30.w,
              child: P1LottieView(name: "finger",width: 72.w,height: 72.w,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
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
                      child: P1Text(text: "Tap This Card → Clear It → Claim Your First Victory!", size: 14.sp, color: "#000000",showShadows: false,),
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