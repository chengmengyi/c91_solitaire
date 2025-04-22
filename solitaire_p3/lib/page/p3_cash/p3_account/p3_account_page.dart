import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/page/p3_cash/p3_account/p3_account_con.dart';

class P3AccountPage extends P1BaseStatelessPage<P3AccountCon>{
  @override
  String bgName() => "";

  @override
  P3AccountCon initCon() => P3AccountCon();

  @override
  Widget contentWidget() => Container(
    color: "#EBEAF2".toColor(),
    child: Column(
      children: [
        _topWidget(),
        _btnWidget(),
      ],
    ),
  );

  _topWidget()=>Stack(
    children: [
      P1Image(name: "account1",width: double.infinity,height: 216.h,),
      SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                P1Image(name: p1Con.type==0?"account2":"account3",height: 31.h,)
              ],
            ),
            SizedBox(height: 100.h,),
            Container(
              width: double.infinity,
              height: 71.h,
              margin: EdgeInsets.only(left: 14.w,right: 14.w),
              padding: EdgeInsets.only(left: 14.w,right: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.w)
              ),
              child: Row(
                children: [
                  P1Text(text: "Account", size: 14.sp, color: "#000000",showShadows: false,),
                  Expanded(
                    child:  TextField(
                      enabled: true,
                      textAlign: TextAlign.right,
                      controller: p1Con.editingController,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: "#000000".toColor(),
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        isCollapsed: true,
                        hintText: p1Con.type==0?'e.g.5551234567':"e.g. 123456789@abc.com",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: "#000000".toColor().withOpacity(0.2),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (v){
                        p1Con.onchange();
                      },
                    ),

                  )
                ],
              ),
            )
          ],
        ),
      )
    ],
  );

  _btnWidget()=>Expanded(
    child: Center(
      child: GetBuilder<P3AccountCon>(
        id: "btn",
        builder: (_)=>InkWell(
          onTap: (){
            p1Con.clickSure();
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 30.w,right: 30.w),
            decoration: BoxDecoration(
                color: (p1Con.editingController.text.isEmpty?"#CCCCCC":"#1ACB9D").toColor(),
                borderRadius: BorderRadius.circular(50.w)
            ),
            child: P1Text(text: "Confirm", size: 14.sp, color: "#FFFFFF",showShadows: false,),
          ),
        ),
      ),
    ),
  );
}