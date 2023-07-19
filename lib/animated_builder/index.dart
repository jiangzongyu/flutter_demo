import 'package:flutter/material.dart';

class AnimatedBuilderTest extends StatefulWidget {
  const AnimatedBuilderTest({Key? key}) : super(key: key);

  @override
  State<AnimatedBuilderTest> createState() => _AnimatedBuilderTestState();
}

class _AnimatedBuilderTestState extends State<AnimatedBuilderTest>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation opacityAnimation =
        Tween(begin: 0.5, end: 0.8).animate(_controller);
    final Animation heightAnimation = Tween(begin: 200.0, end: 300.0)
        .chain(CurveTween(curve: Curves.bounceOut))
        .chain(CurveTween(curve: const Interval(0.2, 0.5)))
        .animate(_controller);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedBuilder'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              // opacity: _controller.value, // 范围 0 ~ 1 获取_controller值的方式为_controller.value方式
              // opacity: Tween(begin: 0.5, end: 0.8).evaluate(_controller), // 通过evaluate方法触发动画
              opacity: opacityAnimation.value,
              child: Container(
                width: 200,
                // height: 200,
                // height: Tween(begin: 200.0, end: 300.0).evaluate(_controller), // 通过evaluate方法触发动画
                height: heightAnimation.value,
                color: Colors.blue,
                child: child,
              ),
            );
          },
          child: const Center(
            child: Text(
              'Hello',
              style: TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }
}
