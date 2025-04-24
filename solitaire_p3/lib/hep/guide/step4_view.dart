import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';

class Step4View extends StatelessWidget{
  Function() clickCall;
  Step4View({
    required this.clickCall,
  });

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: InkWell(
      onTap: (){
        GuideHep.instance.hideOverlay();
        clickCall.call();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 138.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 180.h,left: 45.w,right: 45.w),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    P1Image(name: "new_guide_bg",width: double.infinity,height: 138.h,),
                    Container(
                      margin: EdgeInsets.only(left: 40.w,right: 40.w,bottom: 10.h),
                      child: P1Text(text: "Your Cash Stacks UP! WIN to CLAIM IT NOW!", size: 14.sp, color: "#000000",showShadows: false,),
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