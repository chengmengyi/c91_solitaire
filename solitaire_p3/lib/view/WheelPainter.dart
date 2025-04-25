import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p3/bean/wheel_bean.dart';

class SectorTextPainter extends CustomPainter {
  List<WheelBean> list;
  SectorTextPainter({required this.list});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 * 0.5;

    const numTexts = 8;
    const startAngle = -pi / 2; // 扇形起始角度
    const sweepAngle = pi * 2; // 扇形扫过的角度

    // 计算每个文字之间的角度间隔
    const angleStep = sweepAngle / numTexts;

    for (int i = 0; i < numTexts; i++) {
      var bean = list[i];
      final currentAngle = startAngle + i * angleStep;

      // 计算文字的位置
      final x = center.dx + radius * cos(currentAngle);
      final y = center.dy + radius * sin(currentAngle);

      // 绘制文字
      final textPainter = TextPainter(
        text: TextSpan(
          text: bean.isBox?"??":"+${bean.addNum}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "baloo",
            shadows: [
              Shadow(
                  color: Colors.black,
                  blurRadius: 2.w,
                  offset: Offset(0,0.5.w)
              )
            ]
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // 保存画布状态
      canvas.save();
      // 移动画布到文字的中心位置
      canvas.translate(x, y);
      // 旋转画布到文字的角度
      canvas.rotate(currentAngle + pi / 2);
      // 绘制文字
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      // 恢复画布状态
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
