import 'dart:math';

import 'package:flutter/material.dart';

class SectorTextPainter extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 * 0.5;

    // 定义文字列表
    final texts = ['+10', '+20', '+30', '+40', '+50', '+60', '+70', '+80'];
    const numTexts = 8;
    const startAngle = -pi / 2; // 扇形起始角度
    const sweepAngle = pi * 2; // 扇形扫过的角度

    // 计算每个文字之间的角度间隔
    const angleStep = sweepAngle / numTexts;

    for (int i = 0; i < numTexts; i++) {
      final currentAngle = startAngle + i * angleStep;

      // 计算文字的位置
      final x = center.dx + radius * cos(currentAngle);
      final y = center.dy + radius * sin(currentAngle);

      // 绘制文字
      final textPainter = TextPainter(
        text: TextSpan(
          text: texts[i],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
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
