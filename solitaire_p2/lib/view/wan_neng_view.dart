import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';

class WanNengView extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Stack(
    children: [
      P1Image(name: "wan1",width: 56.w,height: 60.h,),
      P1Image(name: "wan2",width: 56.w,height: 60.h,),
    ],
  );
}