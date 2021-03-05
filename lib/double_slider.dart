import 'package:flutter/material.dart';

const purple = Color.fromRGBO(138, 105, 174, 1.0);

class DoubleSlider extends StatelessWidget {
  final double start;
  final double end;
  final Function(double s, double e) onChanged;

  const DoubleSlider({
    Key? key,
    required this.start,
    required this.end,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: DoubleSliderPainter(start, end),
              ),
            ),
            Positioned(
              left: width * start - 25,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  onChanged(
                    (details.delta.dx / width + start).clamp(0.0, end),
                    end,
                  );
                },
                child: SizedBox(
                  width: 50,
                  height: height,
                  child: CustomPaint(
                    painter: SliderThumbPainter(SliderThumbPosition.start),
                  ),
                ),
              ),
            ),
            Positioned(
              left: width * end - 25,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  onChanged(
                    start,
                    (details.delta.dx / width + end).clamp(start, 1.0),
                  );
                },
                child: Center(
                  child: SizedBox(
                    width: 50,
                    height: height,
                    child: CustomPaint(
                      painter: SliderThumbPainter(SliderThumbPosition.end),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

enum SliderThumbPosition { start, end }

class SliderThumbPainter extends CustomPainter {
  final SliderThumbPosition position;

  SliderThumbPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final dx = (position == SliderThumbPosition.start
        ? rect.center.dx + 1.0
        : rect.center.dx - 1.0);
    final dy = rect.center.dy;
    canvas.drawLine(
        Offset(dx, dy),
        Offset(dx, dy + 10),
        Paint()
          ..color = purple
          ..strokeWidth = 2);
    canvas.drawPath(
        Path()
          ..moveTo(dx, dy + 8)
          ..lineTo(dx - 6, dy + 20)
          ..lineTo(dx + 6, dy + 20)
          ..close(),
        Paint()
          ..color = purple
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant SliderThumbPainter oldDelegate) => false;
}

class DoubleSliderPainter extends CustomPainter {
  final double start;
  final double end;

  DoubleSliderPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    // Background
    canvas.drawLine(
        rect.centerLeft,
        rect.centerRight,
        Paint()
          ..color = Colors.grey.shade300
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round);
    // Slider
    canvas.drawLine(
        Offset(rect.width * start, rect.centerLeft.dy),
        Offset(rect.width * end, rect.centerLeft.dy),
        Paint()
          ..color = purple
          ..strokeWidth = 10);
  }

  @override
  bool shouldRepaint(covariant DoubleSliderPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}
