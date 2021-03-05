import 'package:demo/double_slider.dart';
import 'package:demo/triangle_thumb_shape.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double start = 0.2;
  double end = 0.8;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          sliderTheme: SliderThemeData(rangeThumbShape: TriangleThumbShape())),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 100,
                width: 300,
                child: RangeSlider(
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {
                    setState(() {
                      start = value.start;
                      end = value.end;
                    });
                  },
                  values: RangeValues(start, end),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 100,
                width: 300,
                child: DoubleSlider(
                  start: start,
                  end: end,
                  onChanged: (s, e) {
                    setState(() {
                      start = s;
                      end = e;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
