import 'package:flutter/material.dart';

class AnimatedSwitcherTest extends StatefulWidget {
  const AnimatedSwitcherTest({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitcherTest> createState() => _AnimatedSwitcherTestState();
}

class _AnimatedSwitcherTestState extends State<AnimatedSwitcherTest> {
  double _height = 200;

  void _incrementCounter() {
    setState(() {
      _height += 100.0;
      if (_height > 400) _height = 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedSwitcher'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: 200,
          height: _height,
          color: Colors.blue,
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              // 文字渐变动画
              // return FadeTransition(
              //   opacity: animation,
              //   child: child,
              // );
              // 文字旋转动画
              // return RotationTransition(
              //   turns: animation,
              //   child: child,
              // );
              // 文字缩放动画
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            duration: const Duration(seconds: 1),
            child: Text(
              'Hi',
              key: UniqueKey(),
              style: const TextStyle(fontSize: 50),
            ),
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
