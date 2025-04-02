import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_base/p1_base_stateless_widget.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';

abstract class P1BaseStatelessPage<K extends P1BaseCon> extends P1BaseStatelessWidget<K>{
  @override
  Widget initWidget() => Scaffold(
    body: Stack(
      children: [
        bgName().isEmpty?
        Container():
        P1Image(name: bgName(),width: double.infinity,height: double.infinity,),
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          child: contentWidget(),
        ),
      ],
    ),
  );

  String bgName();

  Widget contentWidget();
}