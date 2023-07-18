import 'package:flutter/material.dart';

class SlideTransitionTest extends StatefulWidget {
  const SlideTransitionTest({Key? key}) : super(key: key);

  @override
  State<SlideTransitionTest> createState() => _SlideTransitionTestState();
}

class _SlideTransitionTestState extends State<SlideTransitionTest>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      // lowerBound: 3, // 下线值从几开始默认从0开始
      // upperBound: 5, // 上线值到几默认到1
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    // _controller.forward(); // 执行一圈
    _controller.repeat(reverse: true); // reverse重复大->小->大
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotation/Fade/Opacity'),
      ),
      body: Center(
        // 移动组件向左、向右、向上、向下
        child: SlideTransition(
          // position: _controller.drive(
          //   Tween(begin: const Offset(0, 0), end: const Offset(1, 0)),
          // ),
          // position: Tween(begin: const Offset(0, 0), end: const Offset(1, 0))
          //     .chain(CurveTween(curve: Curves.elasticInOut))
          //     .animate(_controller), // animate方式可叠加chain方法
          position: Tween(begin: const Offset(0, 0), end: const Offset(1, 0))
              .chain(CurveTween(curve: const Interval(0.2, 0.5)))
              .animate(
                  _controller), // Interval取值范围0 ~ 1，表示在整体5s的时间里取20% ~ 50%的时间执行动画
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
