import 'package:flutter/material.dart';

class AnimatedPaddingTest extends StatefulWidget {
  const AnimatedPaddingTest({Key? key}) : super(key: key);

  @override
  State<AnimatedPaddingTest> createState() => _AnimatedPaddingTestState();
}

class _AnimatedPaddingTestState extends State<AnimatedPaddingTest> {
  double _top = 0;

  void _incrementCounter() {
    setState(() {
      _top = 300;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer'),
      ),
      body: AnimatedPadding(
        duration: const Duration(seconds: 1),
        padding: EdgeInsets.only(top: _top),
        curve: Curves.bounceInOut,
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
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
