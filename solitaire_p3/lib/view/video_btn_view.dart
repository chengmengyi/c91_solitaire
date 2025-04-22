import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';

class VideoBtnView extends StatelessWidget{
  String text;
  Function() clickCall;
  VideoBtnView({
    required this.text,
    required this.clickCall,
});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: (){
      clickCall.call();
    },
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: SizedBox(
      width: 180.w,
      height: 60.h,
      child: Stack(
        children: [
          P1Image(name: "btn_bg3",width: 180.w,height: 60.h,),
          Align(
            alignment: Alignment.center,
            child: P1Text(text: text, size: 26.sp, color: "#FFFFFF",shadowsColor: "#5A1B0B",),
          ),
          Align(
            alignment: Alignment.topRight,
            child: P1Image(name: "buy4",width: 30.w,height: 25.h,),
          ),
        ],
      ),
    ),
  );
  
}