import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';

class P3AccountCon extends P1BaseCon{
  var type=0,amount=0;
  TextEditingController editingController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    var map = P1RouterFun.getArguments();
    type=map["type"];
    amount=map["amount"];
  }

  clickClose(){
    P1RouterFun.closePage();
  }

  clickSure()async{
    var content = editingController.text.trim();
    if(content.isEmpty){
      return;
    }
    if(type==0){
      if(content.length!=10){
        showToast("The format you entered is incorrect.");
        return;
      }
    }else{
      if(!isValidEmail(content)){
        showToast("The format you entered is incorrect.");
        return;
      }
    }
    hideKeyboard();
    await CashTaskHep.instance.createCashTask(type, amount, content);
    P1RouterFun.closePage();
  }

  bool isValidEmail(String email) {
    // 定义邮箱正则表达式
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(email);
  }

  onchange(){
    update(["btn"]);
  }

  hideKeyboard(){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }


  @override
  void onClose() {
    editingController.dispose();
    super.onClose();
  }
}