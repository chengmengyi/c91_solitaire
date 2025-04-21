import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_dialog.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p3/dialog/p3_set_dialog/p3_set_con.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';

class P3SetDialog extends P1BaseStatelessDialog<P3SetCon>{
  bool isHome;
  P3SetDialog({required this.isHome});

  @override
  P3SetCon initCon() => P3SetCon();

  @override
  Widget contentWidget() =>Container(
    width: double.infinity,
    height:382.h,
    margin: EdgeInsets.only(left: 24.w,right: 24.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        P1Image(name: "set1",width: double.infinity,height:382.h),
        P1Image(name: "set2",width: 190.w,height: 44.h,),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !isHome,
                child: Container(
                  margin: EdgeInsets.only(top: 22.h),
                  child: InkWell(
                    onTap: (){
                      p1Con.clickClose();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        P1Image(name: "set3",width: 211.w,height: 46.h,),
                        P1Text(text: "Resume", size: 26.sp, color: "#FFFFFF",shadowsColor: "#0A016B",)
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !isHome,
                child: Container(
                  margin: EdgeInsets.only(top: 22.h),
                  child: InkWell(
                    onTap: (){
                      p1Con.clickHome();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        P1Image(name: "set3",width: 211.w,height: 46.h,),
                        P1Text(text: "To Home", size: 26.sp, color: "#FFFFFF",shadowsColor: "#0A016B",)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 22.h),
                child: InkWell(
                  onTap: (){
                    p1Con.showPrivacy();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      P1Image(name: "set3",width: 211.w,height: 46.h,),
                      P1Text(text: "Privacy Policy", size: 26.sp, color: "#FFFFFF",shadowsColor: "#0A016B",)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<P3SetCon>(
                    id: "music",
                    builder: (_)=>InkWell(
                      onTap: (){
                        p1Con.clickMusic();
                      },
                      child: P1Image(name: p2MusicOpen.getData()?"m_open":"m_close",width: 54.w,height: 54.h,),
                    ),
                  ),
                  SizedBox(width: 40.w,),
                  GetBuilder<P3SetCon>(
                    id: "sound",
                    builder: (_)=>InkWell(
                      onTap: (){
                        p1Con.clickSound();
                      },
                      child: P1Image(name: p2SoundOpen.getData()?"s_open":"s_close",width: 54.w,height: 54.h,),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 16.h,
          right: 26.w,
          child: InkWell(
            onTap: (){
              p1Con.clickClose();
            },
            child: P1Image(name: "icon_close",width: 30.w,height: 30.h,),
          ),
        )
      ],
    ),
  );
}