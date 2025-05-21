import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/dialog/p3_lucky_card/p3_lucky_card_con.dart';
import 'package:solitaire_p3/view/lucky_card_item_view.dart';

class P3LuckyCardDialog extends P1BaseStatelessDialog<P3LuckyCardCon>{
  Function()? dismiss;
  P3LuckyCardDialog({this.dismiss});
  @override
  P3LuckyCardCon initCon() => P3LuckyCardCon();

  @override
  Widget contentWidget() => Container(
    margin: EdgeInsets.only(left: 38.w,right: 38.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                p1Con.clickClose(dismiss);
              },
              child: P1Image(name: "icon_close",width: 30.w,height: 30.h,),
            )
          ],
        ),
        SizedBox(height: 8.h,),
        P1Image(name: "card1",width: double.infinity,height: 56.h,),
        SizedBox(height: 8.h,),
        P1Text(text: "Jackpot Time! Your Big Prize Awaits!", size: 16.sp, color: "#FFFFFF"),
        StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(0),
          itemCount: 6,
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return LuckyCardItemView(
              index: index,
              addNum: p1Con.addNum,
              clickCall: (){
                p1Con.canClick=false;
              },
              animatorEndCall: (){
                p1Con.clickCard(dismiss);
              },
            );
          },
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        ),
      ],
    ),
  );
}