import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get/get.dart';
export 'package:flutter_ad_ios_plugins/data/storage_data.dart';
export 'package:shake_animation_widget/shake_animation_widget.dart';
export 'package:webview_flutter/webview_flutter.dart';
export 'package:decimal/decimal.dart';
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
export 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:app_tracking_transparency/app_tracking_transparency.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';


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

extension String2Dou on String{
  double toDou(){
    try{
      return double.parse(this);
    }catch(e){
      return 0.0;
    }
  }
}

extension RandomList on List{
  random()=> this[Random().nextInt(length)];
}

extension StringBase64 on String{
  String base64()=>const Utf8Decoder().convert(base64Decode(this));
}

showToast(String text){
  if(text.isEmpty){
    return;
  }
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16
  );
}