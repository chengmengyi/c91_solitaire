import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';

class LongJuanFengView extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomRight,
    children: [
      P1Image(name: "wan1",width: 56.w,height: 60.h,),
      P1Image(name: "long1",width: 56.w,height: 60.h,),
      P1Image(name: "long2",width: 30.w,height: 25.h,),
    ],
  );
}