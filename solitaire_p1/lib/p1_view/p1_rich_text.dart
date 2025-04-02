import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

richText({
  required String text,
  required String color,
  required double size,
  bool showShadows = true,
  String? shadowsColor,
})=>TextSpan(
  text: text,
  style: TextStyle(
    color: color.toColor(),
    fontFamily: "baloo",
    fontSize: size,
    height: 1.0,
    shadows: showShadows==true?[
      Shadow(
          color: (shadowsColor??"#000000").toColor(),
          blurRadius: 2.w,
          offset: Offset(0,0.5.w)
      )
    ]:null,
  ),
);