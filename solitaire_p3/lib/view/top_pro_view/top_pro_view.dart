import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_widget.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p3/dialog/p3_lucky_card/p3_lucky_card_dialog.dart';
import 'package:solitaire_p3/view/top_pro_view/top_pro_con.dart';

class TopProView extends P1BaseStatelessWidget<TopProCon>{
  @override
  TopProCon initCon() => TopProCon();

  @override
  Widget initWidget() =>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 12.w,right: 12.w),
    child: Stack(
      children: [
        Stack(
          children: [
            P1Image(name: "pro1",width: double.infinity,height: 44.h,),
            GetBuilder<TopProCon>(
              id: "pro",
              builder: (_)=>Container(
                margin: EdgeInsets.only(top: 14.h,left: 12.w,right: 30.w),
                child: LayoutBuilder(
                  builder: (context,bc){
                    var maxWidth = bc.maxWidth;
                    return Container(
                      width: double.infinity,
                      height: 14.h,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 2.w,right: 2.w),
                      decoration: BoxDecoration(
                        color: "#3E0000".toColor(),
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: Container(
                        width: maxWidth*p1Con.getPro(),
                        height: 8.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: ["#FFC800".toColor(),"#FF7823".toColor()],
                            )
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: P1Image(name: "pro2",width: 44.w,height: 48.h,),
            )
          ],
        )
      ],
    ),
  );
}