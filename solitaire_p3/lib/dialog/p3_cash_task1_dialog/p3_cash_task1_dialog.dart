import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/dialog/p3_cash_task1_dialog/p3_cash_task1_con.dart';

class P3CashTask1Dialog extends P1BaseStatelessDialog<P3CashTask1Con>{
  CashTaskBean bean;
  Function() clickNow;
  P3CashTask1Dialog({required this.bean,required this.clickNow});

  @override
  P3CashTask1Con initCon() => P3CashTask1Con();
  
  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 32.w,right: 32.w),
    decoration: BoxDecoration(
      color: "#F7F0E1".toColor(),
      borderRadius: BorderRadius.circular(14.w),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.w,right: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h,),
              P1Text(text: "Withdrawal Unlock", size: 17.sp, color: "#000000",useFontFamily: false,showShadows: false,fontWeight: FontWeight.bold,),
              P1Text(text: "To ensure the security of your account, you need to complete the following tasks to verify that you are a real person", size: 14.sp, color: "#666666",useFontFamily: false,showShadows: false,),
              SizedBox(height: 16.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: "#EBE0C9".toColor(),
                  borderRadius: BorderRadius.circular(18.w),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        P1Image(name: "task_level",width: 36.w,height: 36.w,),
                        SizedBox(width: 12.w,),
                        Expanded(
                          child: P1Text(text: "Complete the game 5 more times", size: 12.sp, color: "#000000",showShadows: false,),
                        ),
                        SizedBox(width: 12.w,),
                        P1Text(text: "${bean.currentPro??0}/${bean.totalPro??0}", size: 12.sp, color: "#F54A0C",showShadows: false,),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5.h,
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10.h,bottom: 10.h),
                    ),
                    Row(
                      children: [
                        P1Image(name: "task_card",width: 36.w,height: 36.w,),
                        SizedBox(width: 12.w,),
                        Expanded(
                          child: P1Text(text: "Tap 5 cards", size: 12.sp, color: "#000000",showShadows: false,),
                        ),
                        SizedBox(width: 12.w,),
                        P1Text(text: "${bean.currentPro2??0}/${bean.totalPro2??0}", size: 12.sp, color: "#F54A0C",showShadows: false,),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
              SizedBox(height: 34.h,),
              InkWell(
                onTap: (){
                  P1RouterFun.closePage();
                  clickNow.call();
                },
                child: Container(
                  width: 180.w,
                  height: 45.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: "#4283EC".toColor(),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: P1Text(text: "Verify Now", size: 14.sp, color: "#FFFFFF",showShadows: false,useFontFamily: false,fontWeight: FontWeight.bold,),
                ),
              ),
              SizedBox(height: 24.h,),
            ],
          ),
        ),
        Positioned(
          top: 5.h,
          right: 5.w,
          child: InkWell(
            onTap: (){
              P1RouterFun.closePage();
            },
            child: P1Image(name: "icon_close2",width: 24.w,height: 24.w,),
          ),
        )
      ],
    ),
  );
}