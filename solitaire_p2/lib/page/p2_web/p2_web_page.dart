import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/page/p2_web/p2_web_con.dart';

class P2WebPage extends P1BaseStatelessPage<P2WebCon>{
  @override
  String bgName() => "level101";

  @override
  P2WebCon initCon() => P2WebCon();

  @override
  Widget contentWidget() => SafeArea(
    child: Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54.h,
          child: Stack(
            children: [
              InkWell(
                onTap: (){
                  P1RouterFun.closePage();
                },
                child: Container(
                  width: 54.w,
                  height: 54.h,
                  alignment: Alignment.center,
                  child: P1Image(name: "icon_close",width: 30.w,height: 30.h,),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: P1Text(text: "Privacy Policy", size: 26.sp, color: "#FFFFFF",shadowsColor: "#0A016B",),
              ),
            ],
          ),
        ),
        Expanded(child: WebViewWidget(controller: p1Con.controller))
      ],
    ),
  );
}