import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p1/p1_view/p1_rich_text.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';

class RankGuideView extends StatelessWidget{
  Offset offset;
  Size size;
  Function() clickCall;
  RankGuideView({
    required this.offset,
    required this.size,
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
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy+size.height-40.h,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 30.w,right: 30.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    P1LottieView(name: "finger",width: 72.w,height: 72.w,).marginOnly(right: 50.w),
                    P1Text(text: "No need to wait to watch ads,\$100 Cash out faster!", size: 14.sp, color: "#FFFFFF",showShadows: false,useFontFamily: false,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}