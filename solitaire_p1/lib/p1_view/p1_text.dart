import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

class P1Text extends StatelessWidget{
  String text;
  double size;
  String color;
  bool showShadows;
  String? shadowsColor;
  TextDecoration? decoration;
  Color? decorationColor;
  bool useFontFamily;
  FontWeight? fontWeight;
  TextAlign? textAlign;

  P1Text({
    required this.text,
    required this.size,
    required this.color,
    this.showShadows=true,
    this.shadowsColor,
    this.decoration,
    this.decorationColor,
    this.useFontFamily=true,
    this.fontWeight,
    this.textAlign,
});
  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color.toColor(),
      fontFamily: useFontFamily?"baloo":null,
      fontSize: size,
      decoration: decoration,
      decorationColor: decorationColor,
      fontWeight: fontWeight,
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