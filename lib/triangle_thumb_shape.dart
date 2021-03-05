import 'package:flutter/material.dart';

class TriangleThumbShape extends RangeSliderThumbShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(30, 40);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final canvas = context.canvas;
    final dx = (thumb! == Thumb.start ? center.dx + 1.0 : center.dx - 1.0);
    final dy = center.dy;
    canvas.drawLine(
        Offset(dx, dy),
        Offset(dx, dy + 10),
        Paint()
          ..color = sliderTheme.thumbColor ?? Colors.blueAccent
          ..strokeWidth = 2);
    canvas.drawPath(
        Path()
          ..moveTo(dx, dy + 8)
          ..lineTo(dx - 6, dy + 20)
          ..lineTo(dx + 6, dy + 20)
          ..close(),
        Paint()
          ..color = sliderTheme.thumbColor ?? Colors.blueAccent
          ..style = PaintingStyle.fill);
  }
}
