import 'package:flutter/material.dart';

// 使用不太多主要用 ChangeNotifier 比较多，简单了解 ValueNotifier 即可
class ValueNotifierTest extends StatefulWidget {
  const ValueNotifierTest({super.key});

  @override
  State<ValueNotifierTest> createState() => _ValueNotifierTestState();
}

class _ValueNotifierTestState extends State<ValueNotifierTest> {
  final _controller = FooController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueNotifier'),
      ),
      body: Column(
        children: [
          Foo(controller: _controller),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.count.value = 0;
          _controller.fontSize.value += 10;
        },
        tooltip: 'Clear',
        child: const Icon(Icons.clear),
      ),
    );
  }
}

class Foo extends StatefulWidget {
  final FooController controller;

  const Foo({super.key, required this.controller});

  @override
  State<Foo> createState() => _FooState();
}

class _FooState extends State<Foo> {
  @override
  Widget build(BuildContext context) {
    print('_FooState rebuild');
    return ElevatedButton(
      onPressed: () {
        widget.controller.count.value++;
      },
      child: ListenableBuilder(
        listenable: Listenable.merge([
          widget.controller.count,
          widget.controller.fontSize,
        ]),
        builder: (BuildContext context, Widget? child) {
          print('ListenableBuilder rebuild');
          return Text(
            'Cont: ${widget.controller.count.value}',
            style: TextStyle(fontSize: widget.controller.fontSize.value),
          );
        },
      ),
    );
  }
}

class FooController {
  ValueNotifier<int> count = ValueNotifier(0);
  ValueNotifier<double> fontSize = ValueNotifier(48);
}
