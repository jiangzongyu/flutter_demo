import 'package:flutter/material.dart';

class TransitionTest extends StatefulWidget {
  const TransitionTest({Key? key}) : super(key: key);

  @override
  State<TransitionTest> createState() => _TransitionTestState();
}

class _TransitionTestState extends State<TransitionTest>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
        title: const Text('Transition'),
      ),
      body: Center(
        // child: RotationTransition(
        //   turns: _controller,
        //   child: Container(
        //     width: 200,
        //     height: 200,
        //     color: Colors.blue,
        //   ),
        // child: FadeTransition(
        //   opacity: _controller,
        //   child: Container(
        //     width: 200,
        //     height: 200,
        //     color: Colors.blue,
        //   ),
        // ),
        child: ScaleTransition(
          scale: _controller,
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
