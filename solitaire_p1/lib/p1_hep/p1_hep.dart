import 'dart:math';

import 'package:flutter/material.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get/get.dart';
export 'package:flutter_ad_ios_plugins/data/storage_data.dart';
export 'package:shake_animation_widget/shake_animation_widget.dart';


extension String2Color on String{
  Color toColor(){
    var hexStr = replaceAll("#", "");
    return Color(int.parse(hexStr, radix: 16)).withAlpha(255);
  }
}

extension String2Inr on String{
  int toInt(){
    try{
      return int.parse(this);
    }catch(e){
      return 0;
    }
  }
}

extension RandomList on List{
  random()=> this[Random().nextInt(length)];
}