import 'dart:math';

import 'package:flutter/material.dart';


class PokerAnimation extends StatefulWidget {
  const PokerAnimation({super.key});
  @override
  State<PokerAnimation> createState() => _PokerAnimationState();
}
class _PokerAnimationState extends State<PokerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<String> pokerCards = [
    'A♦', 'K♣', 'A♠', 'Q♥' // 可按需添加更多扑克牌
  ];
  List<Offset> cardPositions = [];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
    _initCardPositions();
  }
  void _initCardPositions() {
    final random = Random();
    for (int i = 0; i < pokerCards.length; i++) {
      double x = random.nextDouble() * MediaQuery.of(context).size.width;
      double y = -MediaQuery.of(context).size.height;
      cardPositions.add(Offset(x, y));
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: pokerCards.asMap().entries.map((entry) {
        int index = entry.key;
        String card = entry.value;
        double t = _animation.value * (index + 1) / pokerCards.length;
        Offset start = cardPositions[index];
        Offset end = Offset(
          start.dx,
          MediaQuery.of(context).size.height / 2,
        );
        Offset current = Offset.lerp(start, end, t)?? start;
        return Positioned(
          left: current.dx,
          top: current.dy,
          child: Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                card,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
