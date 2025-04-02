import 'package:flutter/material.dart';

class P1Image extends StatelessWidget{
  String name;
  double? width;
  double? height;
  BoxFit? fit;

  P1Image({
    required this.name,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset("solitaire_image/$name.webp",width: width,height: height,fit: fit??BoxFit.fill,);
  }
}