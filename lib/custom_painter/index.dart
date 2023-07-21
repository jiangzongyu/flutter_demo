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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
        title: const Text('CustomPainter'),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: CustomPaint(
            painter: MyPainter(),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    canvas.drawCircle(size.center(Offset(0.0, 90.0)), 50.0, Paint());
    canvas.drawOval(
      Rect.fromCenter(
          center: size.center(Offset(0, 250)), width: 200, height: 250),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
