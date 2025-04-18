import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_widget.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/hep/p2_play.dart';
import 'package:solitaire_p2/view/bottom/p2_bottom_view_con.dart';
import 'package:solitaire_p2/view/longjuanfeng_view.dart';
import 'package:solitaire_p2/view/wan_neng_view.dart';

class P2BottomView extends P1BaseStatelessWidget<P2BottomViewCon>{
  P2Play p2play;
  P2BottomView({required this.p2play});
  
  @override
  P2BottomViewCon initCon() => P2BottomViewCon();

  @override
  initView() {
    p1Con.p2play=p2play;
  }
  
  @override
  Widget initWidget() => Row(
    children: [
      SizedBox(width: 22.w,),
      InkWell(
        onTap: (){
          p1Con.changeHandCard();
        },
        child: SizedBox(
          width: 90.w,
          child: GetBuilder<P2BottomViewCon>(
            id: "hand_card_num",
            builder: (_){
              var length = p1Con.p2play.currentHandsNum<5?p1Con.p2play.currentHandsNum:5;
              return Stack(
                children: List.generate(length, (index) => Container(
                  margin: EdgeInsets.only(left: (10.w)*index),
                  child: Stack(
                    alignment: Alignment.bottomCenter ,
                    children: [
                      P1Image(name: "card_back",width: 50.w,height: 78.h,),
                      Visibility(
                        visible: length==index+1,
                        child: Container(
                          width: 42.w,
                          height: 14.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: "#000000".toColor().withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20.w)
                          ),
                          child: P1Text(text: "${p1Con.p2play.currentHandsNum}", size: 14.sp, color: "#FFFFFF"),
                        ),
                      )
                    ],
                  ),
                )),
              );
            },
          ),
        ),
      ),
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: GetBuilder<P2BottomViewCon>(
            id: "hand_card",
            builder: (_)=>null==p1Con.p2play.currentHandCard?
            Container():
            P1Image(name: p1Con.p2play.getHandCardImageIcon(),width: 50.w,height: 78.h,),
          ),
        ),
      ),
      InkWell(
        onTap: (){
          p1Con.clickWanNeng();
        },
        child: WanNengView(),
      ),
      SizedBox(width: 12.w,),
      InkWell(
        onTap: (){
          p1Con.clickLongJuanFeng();
        },
        child: LongJuanFengView(),
      ),
      SizedBox(width: 22.w,),
    ],
  );
}