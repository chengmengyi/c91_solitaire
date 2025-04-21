import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p3/dialog/p3_set_dialog/p3_set_dialog.dart';

class SetView extends StatelessWidget{
  bool isHome;
  SetView({this.isHome=false,});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: (){
      P1RouterFun.showDialog(w: P3SetDialog(isHome: isHome));
    },
    child: P1Image(name: "set",width: 34.w,height: 34.w,),
  );
}