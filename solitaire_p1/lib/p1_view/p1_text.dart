import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

class P1Text extends StatelessWidget{
  String text;
  double size;
  String color;
  bool showShadows;
  String? shadowsColor;

  P1Text({
    required this.text,
    required this.size,
    required this.color,
    this.showShadows=true,
    this.shadowsColor,
});
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      color: color.toColor(),
      fontFamily: "baloo",
      fontSize: size,
      shadows: showShadows==true?[
        Shadow(
            color: (shadowsColor??"#000000").toColor(),
            blurRadius: 2.w,
            offset: Offset(0,0.5.w)
        )
      ]:null,
    ),
  );

}