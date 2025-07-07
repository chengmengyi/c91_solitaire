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

  static offAllUnit({required String routers}){
    Get.until((route) => route.settings.name==routers);
  }

  static closePage({Map<String,dynamic>? result}){
    Get.back(result: result);
  }

  static toNextPage({required String str,Map<String, dynamic>? p,Function(Map<String, dynamic>)? resultCallback})async{
    Get.toNamed(str,arguments: p)?.then((value){
      if(null!=value){
        resultCallback?.call(value);
      }
    });
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