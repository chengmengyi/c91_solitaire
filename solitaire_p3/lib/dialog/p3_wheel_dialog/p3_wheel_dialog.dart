import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_rich_text.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/dialog/p3_wheel_dialog/p3_wheel_con.dart';
import 'package:solitaire_p3/view/WheelPainter.dart';

class P3WheelDialog extends P1BaseStatelessDialog<P3WheelCon>{
  Function()? dismiss;
  P3WheelDialog({this.dismiss});
  @override
  P3WheelCon initCon() => P3WheelCon();

  @override
  initView() {
    p1Con.dismiss=dismiss;
  }

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 10.w,right: 10.w),
    child:  Stack(
      children: [
        _contentWidget(),
        _topWidget(),
      ],
    ),
  );

  _topWidget()=>SizedBox(
    width: double.infinity,
    height: 56.h,
    child: Row(
      children: [
        SizedBox(width: 30.w,),
        Expanded(
          child: P1Image(name: "wheel1",height: 56.h,),
        ),
        SizedBox(width: 10.w,),
        InkWell(
          onTap: (){
            p1Con.clickClose(dismiss);
          },
          child: P1Image(name: "icon_close",width: 30.w,height: 30.h,),
        ),
      ],
    ),
  );
  
  _contentWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 30.h),
    decoration: BoxDecoration(
      color: "#000000".toColor().withOpacity(0.9),
      borderRadius: BorderRadius.circular(26.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 40.h,),
        P1Text(text: "\$200", size: 30.sp, color: "#0EFF47"),
        RichText(
          text: TextSpan(
            children: [
              richText(text: "Just ", color: "#FFFFFF", size: 16.sp,),
              richText(text: "\$0.05", color: "#0EFF47", size: 16.sp,),
              richText(text: " to Pagbank withdrawal.", color: "#FFFFFF", size: 16.sp,),
            ]
          ),
        ),
        SizedBox(height: 8.h,),
        Container(
          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            color: "#003531".toColor().withOpacity(0.6),
          ),
          child: P1Text(text: "You Must Withdraw \$50 This Time!", size: 13.sp, color: "#1FE5FF"),
        ),
        SizedBox(height: 8.h,),
        _wheelWidget(),
        SizedBox(height: 60.h,),
      ],
    ),
  );

  _wheelWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 18.w,right: 18.w),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 33.h),
          child: AnimatedBuilder(
            animation: p1Con.animation,
            builder: (context,child)=>Transform.rotate(
              angle: p1Con.animation.value,
              child: Stack(
                children: [
                  P1Image(name: p1Con.showBox?"wheel4":"wheel3",width: 260.w, height: 260.h,),
                  CustomPaint(
                    painter: SectorTextPainter(list: p1Con.coinsList),
                    size: Size(260.w, 260.h),
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (){
            p1Con.startAnimator(dismiss);
          },
          child: P1Image(name: "wheel2",width: double.infinity,height: 370.h,),
        ),
      ],
    ),
  );
}