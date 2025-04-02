import 'package:flutter/material.dart';
import 'package:solitaire/launch/launch_con.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_page.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';

class LaunchPage extends P1BaseStatelessPage<LaunchCon>{

  @override
  LaunchCon initCon() => LaunchCon();

  @override
  String bgName() => "launch1";

  @override
  Widget contentWidget() => Column(
    children: [
      const Spacer(),
      firstLaunch.getData()?_playWidget():_progressWidget(),
      SizedBox(height: 80.h,),
    ],
  );
  
  _progressWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      P1Text(text: "Loading...", size: 18.sp, color: "#FFFFFF"),
      SizedBox(height: 10.h,),
      Stack(
        children: [
          P1Image(name: "launch2",width: 300.w,height: 14.h,),
          GetBuilder<LaunchCon>(
            id: "progress",
            builder: (_)=>ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: p1Con.animationController.value,
                child: P1Image(name: "launch3",width: 300.w,height: 14.h,),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 26.h,)
    ],
  );

  _playWidget()=> InkWell(
    onTap: (){
      p1Con.clickPlay();
    },
    child: P1Image(name: "home2",width: 186.w,height: 70.h,),
  );

}