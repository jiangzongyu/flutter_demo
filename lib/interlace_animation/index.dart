import 'package:flutter/material.dart';

class InterlaceAnimation extends StatefulWidget {
  const InterlaceAnimation({Key? key}) : super(key: key);

  @override
  State<InterlaceAnimation> createState() => _InterlaceAnimationState();
}

class _InterlaceAnimationState extends State<InterlaceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(reverse: true);
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
        title: const Text('交错动画'),
      ),
      body: Center(
        child: Column(
          children: [
            SlidingBox(
              controller: _controller,
              color: Colors.blue[100],
              interval: Interval(0.0, 0.2),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[300],
              interval: Interval(0.2, 0.4),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[500],
              interval: Interval(0.4, 0.6),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[700],
              interval: Interval(0.6, 0.8),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[900],
              interval: Interval(0.8, 1.0),
            ),
          ],
        ),
      ),
    );
  }
}

class SlidingBox extends StatelessWidget {
  const SlidingBox({
    super.key,
    required AnimationController controller,
    required this.color,
    required this.interval,
  }) : _controller = controller;

  final AnimationController _controller;
  final Color? color;
  final Interval interval;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: Offset(0.1, 0))
          .chain(CurveTween(curve: Curves.bounceOut))
          .chain(CurveTween(curve: interval))
          .animate(_controller),
      child: Container(width: 200, height: 100, color: color),
    );
  }
}
