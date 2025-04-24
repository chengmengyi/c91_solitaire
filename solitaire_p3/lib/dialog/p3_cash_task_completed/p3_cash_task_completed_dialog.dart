import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/dialog/p3_cash_task_completed/p3_cash_task_completed_con.dart';

class P3CashTaskCompletedDialog extends P1BaseStatelessDialog<P3CashTaskCompletedCon>{
  CashTaskBean bean;
  P3CashTaskCompletedDialog({required this.bean});

  @override
  P3CashTaskCompletedCon initCon() => P3CashTaskCompletedCon();

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    padding: EdgeInsets.only(left: 10.w,right: 10.w),
    margin: EdgeInsets.only(left: 32.w,right: 32.w),
    decoration: BoxDecoration(
      color: "#F7F0E1".toColor(),
      borderRadius: BorderRadius.circular(14.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.h,),
        P1Text(text: "Congratulations!", size: 17.sp, color: "#000000",useFontFamily: false,showShadows: false,fontWeight: FontWeight.bold,),
        P1Text(text: "We have completed the payment.And the funds will be creadited to your bank account within 7 business days.", size: 14.sp, color: "#666666",useFontFamily: false,showShadows: false,),

        SizedBox(height: 34.h,),
        InkWell(
          onTap: (){
            p1Con.clickSure(bean);
          },
          child: Container(
            width: 180.w,
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: "#4283EC".toColor(),
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: P1Text(text: "Instantly Credited", size: 14.sp, color: "#FFFFFF",showShadows: false,useFontFamily: false,fontWeight: FontWeight.bold,),
          ),
        ),
        SizedBox(height: 24.h,),
      ],
    ),
  );
}