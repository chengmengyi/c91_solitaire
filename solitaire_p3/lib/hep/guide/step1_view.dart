import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_rich_text.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';

class Step1View extends StatelessWidget{
  Function() clickCall;
  Step1View({required this.clickCall});

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
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 45.w,right: 45.w),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                P1Image(name: "new_guide_bg",width: double.infinity,height: 138.h,),
                Container(
                  margin: EdgeInsets.only(left: 40.w,right: 40.w,bottom: 10.h),
                  child: RichText(
                    text: TextSpan(
                        children: [
                          //Hi! Made $400 last week – started where you are! Your turn！
                          richText(text: "Hi! Made ", color: "#000000", size: 14.sp,showShadows: false),
                          richText(text: "\$400", color: "#149900", size: 14.sp,showShadows: false),
                          richText(text: " last week – started where you are! Your turn！", color: "#000000", size: 14.sp,showShadows: false),
                        ]
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}