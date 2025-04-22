import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P1RouterFun{
  static showDialog({required Widget w,dynamic p, bool? barrierDismissible, Color? bc}){
    Get.dialog(
      w,
      arguments: p,
      barrierColor: bc,
      barrierDismissible: barrierDismissible ?? false,
    );
  }

  static toNextPageAndCloseCurrent({required String str}){
    Get.offNamed(str);
  }

  static closePage(){
    Get.back();
  }

  static toNextPage({required String str,Map<String, dynamic>? p})async{
    Get.toNamed(str,arguments: p);
  }

  static toHome({required String str}){
    Get.until((route)=>route.settings.name==str);
  }

  static Map<String, dynamic> getArguments() {
    try {
      return Get.arguments as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}