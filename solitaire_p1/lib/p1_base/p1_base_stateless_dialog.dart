
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_widget.dart';

abstract class P1BaseStatelessDialog<K extends P1BaseCon> extends P1BaseStatelessWidget<K>{
  @override
  Widget initWidget() => Material(
    type: MaterialType.transparency,
    child: WillPopScope(
      child: Center(
        child: contentWidget(),
      ),
      onWillPop: ()async{
        return false;
      },
    ),
  );

  Widget contentWidget();
}