import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/hep.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/page/p3_cash/p3_cash/p3_cash_con.dart';

class P3CashPage extends P1BaseStatelessPage<P3CashCon>{
  @override
  String bgName() => "";

  @override
  P3CashCon initCon() => P3CashCon();

  @override
  Widget contentWidget() => Container(
    color: "#EBEAF2".toColor(),
    child: Column(
      children: [
        _topWidget(),
        _cashTypeWidget(),
        _amountWidget(),
      ],
    ),
  );
  
  _topWidget()=>Stack(
    children: [
      P1Image(name: "cash1",width: double.infinity,height: 174.h,),
      SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                p1Con.clickClose();
              },
              child: Container(
                width: 46.w,
                height: 46.w,
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_back,color: Colors.white,),
              ),
            ),
            Container(
              width: double.infinity,
              height: 134.h,
              margin: EdgeInsets.only(left: 12.w,right: 12.w),
              child: Stack(
                children: [
                  P1Image(name: "cash3",width: double.infinity,height: 140.h,),
                  Positioned(
                    top: 16.h,
                    left: 16.w,
                    child: P1Text(text: "Balance", size: 15.sp, color: "#000000",showShadows: false,),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 38.h),
                      child: GetBuilder<P3CashCon>(
                        id: "coins",
                        builder: (_)=>P1Text(text: "\$${p3Coins.getData()}", size: 29.sp, color: "#1E7419",showShadows: false,),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ],
  );

  _cashTypeWidget()=>Container(
    margin: EdgeInsets.only(left: 15.w,right: 15.w,),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        P1Text(text: "Choose Your Withdrawal Method", size: 15.sp, color: "#010101",showShadows: false,),
        SizedBox(height: 8.h,),
        GetBuilder<P3CashCon>(
          id: "cash_type",
          builder: (_)=>Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    p1Con.clickCashType(CashType.cashApp);
                  },
                  child: Container(
                    width: double.infinity,
                    key: p1Con.cashTypeGlobalKey,
                    height: p1Con.cashType==0?57.h:53.h,
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: "#FFFFFF".toColor(),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Visibility(
                          visible: p1Con.cashType==0,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                                gradient: LinearGradient(
                                    colors: ["#B1FFE2".toColor(),"#C3FED9".toColor(),]
                                )
                            ),
                          ),
                        ),
                        P1Image(name: "cash5",width: 100.w,height: 30.h,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: InkWell(
                  onTap: (){
                    p1Con.clickCashType(CashType.paypal);
                  },
                  child: Container(
                    width: double.infinity,
                    height: p1Con.cashType==1?57.h:53.h,
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: "#FFFFFF".toColor(),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Visibility(
                          visible: p1Con.cashType==1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                                gradient: LinearGradient(
                                    colors: ["#B1ECFF".toColor(),"#C3CDFE".toColor(),]
                                )
                            ),
                          ),
                        ),
                        P1Image(name: "cash6",width: 80.w,height: 30.h,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );

  _amountWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 20.h),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        P1Text(text: "Select Withdrawal Amount", size: 15.sp, color: "#010101",showShadows: false,),
        GetBuilder<P3CashCon>(
          id: "list",
          builder: (_)=>MediaQuery.removePadding(
            context: p1Con.context,
            removeTop: true,
            removeBottom: true,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: p1Con.amountList.length,
              itemBuilder: (context,index){
                var bean = p1Con.amountList[index];
                return InkWell(
                  onTap: (){
                    p1Con.clickAmount(index);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 117.h,
                    key: index==0?p1Con.cashMoneyGlobalKey:null,
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
                          child: P1Image(name: p1Con.cashType==0?"cash5":"cash6",height: 30.h,),
                        ),
                        Align(
                          child: Visibility(
                            visible: null==bean.cashTaskBean,
                            child: P1Text(text: "\$${bean.money}", size: 38.sp, color: "#D66400",showShadows: false,),
                          ),
                        ),
                        Positioned(
                          top: 6.h,
                          right: 16.w,
                          child: Visibility(
                            visible: null!=bean.cashTaskBean,
                            child: P1Text(text: "\$${bean.money}", size: 38.sp, color: "#D66400",showShadows: false,),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _taskProWidget(bean.cashTaskBean),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    ),
  );

  _taskProWidget(CashTaskBean? bean){
    if(null==bean){
      return Container();
    }
    return Container(
      width: double.infinity,
      height: 45.h,
      padding: EdgeInsets.only(left: 10.w,right: 10.w),
      margin: EdgeInsets.only(left: 6.w,right: 6.w,bottom: 6.h),
      decoration: BoxDecoration(
        color: "#F5F5F5".toColor(),
        borderRadius: BorderRadius.circular(14.w),
      ),
      child: Row(
        children: [
          P1Image(name: getTaskIcon(bean),width: 36.w,height: 36.w,),
          SizedBox(width: 12.w,),
          Expanded(
            child: P1Text(text: getTaskStr(bean), size: 12.sp, color: "#000000",showShadows: false,),
          ),
          SizedBox(width: 12.w,),
          Visibility(
            visible: bean.cashTask!=CashTask.complete,
            child: P1Text(text: bean.cashTask==CashTask.complete?"5/5":"${bean.currentPro??0}/${bean.totalPro??0}", size: 12.sp, color: "#F54A0C",showShadows: false,),
          ),
        ],
      ),
    );
  }
}