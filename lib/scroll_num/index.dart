import 'package:flutter/material.dart';

class ScrollNum extends StatefulWidget {
  const ScrollNum({Key? key}) : super(key: key);

  @override
  State<ScrollNum> createState() => _ScrollNumState();
}

class _ScrollNumState extends State<ScrollNum> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScrollNum示例'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 120,
          color: Colors.blue,
          child: Counter(value: _counter),
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

// 如果多位数字需要翻转则在column中写入多个Counter每个Counter控制每位数字
class Counter extends StatelessWidget {
  final int value;

  const Counter({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 1),
      tween: Tween(end: value.toDouble()),
      builder: (BuildContext context, double value, Widget? child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        return Stack(
          children: [
            Positioned(
              top: -100 * decimal,
              child: Opacity(
                opacity: 1.0 - decimal,
                child: Text(
                  '$whole',
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
            Positioned(
              top: 100 - decimal * 100,
              child: Opacity(
                opacity: decimal,
                child: Text(
                  '${whole + 1}',
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
