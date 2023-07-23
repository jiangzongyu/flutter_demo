import 'dart:math';

import 'package:flutter/material.dart';

// 操作底层CustomPainter
class CustomPainterTest extends StatefulWidget {
  const CustomPainterTest({Key? key}) : super(key: key);

  @override
  State<CustomPainterTest> createState() => _CustomPainterTestState();
}

class _CustomPainterTestState extends State<CustomPainterTest>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Snowflake> _snowflake = List.generate(100, (index) => Snowflake());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPainter&雪人'),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              for (var element in _snowflake) {
                element.fall();
              }
              return CustomPaint(
                painter: MyPainter(_snowflake),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  late final List<Snowflake> _snowflake;

  MyPainter(this._snowflake);

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      size.center(const Offset(0.0, 90.0)),
      50.0,
      whitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: size.center(const Offset(0, 250)),
        width: 200,
        height: 250,
      ),
      whitePaint,
    );
    for (var snowflake in _snowflake) {
      canvas.drawCircle(
        Offset(snowflake.x, snowflake.y),
        snowflake.radius,
        whitePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Snowflake {
  double x = Random().nextDouble() * 400;
  double y = Random().nextDouble() * 800;
  double radius = Random().nextDouble() * 2 + 2;
  double velocity = Random().nextDouble() * 4 + 2;

  fall() {
    y += velocity;
    if (y > 800) {
      y = 0;
      x = Random().nextDouble() * 400;
      radius = Random().nextDouble() * 2 + 2;
      velocity = Random().nextDouble() * 4 + 2;
    }
  }
}
