import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/bean/rank_task_bean.dart';
import 'package:solitaire_p3/dialog/p3_rank_dialog/p3_rank_dialog_controller.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3RankDialog extends P1BaseStatelessDialog<P3RankDialogController>{
  RankTaskBean? rankTaskBean;
  P3RankDialog({
    required this.rankTaskBean,
});

  @override
  P3RankDialogController initCon() => P3RankDialogController();

  @override
  initView() {
    p1Con.init(rankTaskBean);
  }

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    key: p1Con.contentGlobalKey,
    margin: EdgeInsets.only(left: 34.w,right: 34.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.w),
      color: "#FFFFFF".toColor(),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        _closeWidget(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _topWidget(),
            SizedBox(height: 16.h,),
            _rankWidget(),
            SizedBox(height: 16.h,),
            _skipBtnWidget(),
            SizedBox(height: 16.h,),
          ],
        )
      ],
    ),
  );
  
  _topWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 22.h,),
      P1Text(text: "Withdraw Approval", size: 17.sp, color: "#000000",fontWeight: FontWeight.bold,showShadows: false,useFontFamily: false,),
      SizedBox(height: 16.h,),
      Container(
        width: 152.w,
        height: 82.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          gradient: LinearGradient(
            colors: ["#B1ECFF".toColor(),"#C3CDFE".toColor(),]
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            P1Image(name: rankTaskBean?.cashType==CashType.cashApp?"cash5":"cash6",height: 30.h,fit: BoxFit.fitHeight,),
            P1Text(text: "${rankTaskBean?.amount??0}", size: 23.sp, color: "#000000",fontWeight: FontWeight.bold,showShadows: false,useFontFamily: false,)
          ],
        ),
      ),
      SizedBox(height: 16.h,),
      P1Text(text: "Congratulations, You are in the withdrawal approval queue.", size: 14.sp, color: "#333333",useFontFamily: false,showShadows: false,textAlign: TextAlign.center,fontWeight: FontWeight.bold,).marginOnly(left: 20.w,right: 20.w)
    ],
  );

  _rankWidget()=>GetBuilder<P3RankDialogController>(
    id: "rank",
    builder: (_)=>Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
              children: [
                TextSpan(
                    text: "${p1Con.rankTaskBean?.totalPro??0}",
                    style: TextStyle(
                      color: "#FF1E00".toColor(),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    )
                ),
                TextSpan(
                    text: " in queue， Your Current rank ",
                    style: TextStyle(
                      color: "#333333".toColor(),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    )
                ),
                TextSpan(
                    text: "${p1Con.rankTaskBean?.currentPro??0}",
                    style: TextStyle(
                      color: "#FF1E00".toColor(),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ]
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          height: 208.h,
          margin: EdgeInsets.only(left: 20.w,right: 20.w),
          decoration: BoxDecoration(
            color: "#FBF7EE".toColor(),
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 34.h,
                child: Row(
                  children: [
                    _rankTitleWidget("Rank"),
                    _rankTitleWidget("Account"),
                    _rankTitleWidget("Amount"),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: p1Con.rankList.length,
                  itemBuilder: (context,index){
                    var isMe = index+1==p1Con.rankTaskBean?.currentPro;
                    return Container(
                      width: double.infinity,
                      height: 23.h,
                      color: index%2==0?"#F2ECDB".toColor():null,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: P1Text(text: "${index+1}", size: 12.sp, color: isMe?"B71C1C":"#000000",useFontFamily: false,showShadows: false,),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: P1Text(text: p1Con.getAccountStr(p1Con.rankList[index]), size: 12.sp, color: isMe?"B71C1C":"#000000",useFontFamily: false,showShadows: false,),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: P1Text(text: "\$${isMe?p1Con.rankTaskBean?.amount:P3ValueHep.instance.getCashAmountList().random()}", size: 12.sp, color: isMe?"B71C1C":"#000000",useFontFamily: false,showShadows: false,),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    ),
  );

  _rankTitleWidget(text)=>Expanded(
    child: Center(
      child: P1Text(text: text, size: 12.sp, color: "#000000",useFontFamily: false,showShadows: false,),
    ),
  );

  _skipBtnWidget()=>InkWell(
    onTap: (){
      p1Con.clickSkip();
    },
    child: Container(
      width: 180.w,
      height: 45.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: "#4283EC".toColor(),
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: P1Text(text: "Skip Wait", size: 16.sp, color: "#FFFFFF",useFontFamily: false,showShadows: false,fontWeight: FontWeight.bold,),
    ),
  );

  _closeWidget()=>Positioned(
    top: 0,
    right: 0,
    child: InkWell(
      onTap: (){
        p1Con.clickClose();
      },
      child: Container(
        width: 36.w,
        height: 36.w,
        alignment: Alignment.center,
        child: P1Image(name: "icon_close3",width: 12.w,height: 12.w,),
      ),
    ),
  );
}