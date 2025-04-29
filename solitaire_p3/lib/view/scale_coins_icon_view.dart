import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';

class ScaleCoinsIconView extends StatefulWidget{
  double? width;
  double? height;
  ScaleCoinsIconView({
    this.width,
    this.height,
});

  @override
  State<StatefulWidget> createState() => _ScaleCoinsIconViewState();
}

class _ScaleCoinsIconViewState extends State<ScaleCoinsIconView> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: animation,
    child: P1Image(name: "get3",width: widget.width??130.w,height: widget.height??120.h,),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}