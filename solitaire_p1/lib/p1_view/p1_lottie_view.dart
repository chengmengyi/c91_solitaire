import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class P1LottieView extends StatelessWidget{
  String name;
  String? ext;
  double? width;
  double? height;
  bool? repeat;
  Animation<double>? controller;

  P1LottieView({
    required this.name,
    this.ext,
    this.width,
    this.height,
    this.repeat,
    this.controller,
  });
  @override
  Widget build(BuildContext context) => Lottie.asset(
    "solitaire_lottie/$name.${ext??"json"}",
    width: width,
    height: height,
    fit: BoxFit.fitWidth,
    repeat: repeat??true,
    controller: controller,
  );

}