import 'package:flutter/material.dart';

class RotationTransitionTest extends StatefulWidget {
  const RotationTransitionTest({Key? key}) : super(key: key);

  @override
  State<RotationTransitionTest> createState() => _RotationTransitionTestState();
}

class _RotationTransitionTestState extends State<RotationTransitionTest>
    with SingleTickerProviderStateMixin {
  bool _loading = true;

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    if (_loading) {
      _controller.repeat(); // 重复执行
      // _controller.forward(); // 执行一圈
    } else {
      _controller.reset(); // 重置位置
      // _controller.stop(); // 点击时停止在当前位置
    }
    _loading = !_loading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RotationTransition'),
      ),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: const Icon(
            Icons.refresh,
            size: 100,
          ),
          // child: CircularProgressIndicator(), // 自带的loading组件
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
