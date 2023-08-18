import 'package:flutter/material.dart';

class ControllerTest extends StatefulWidget {
  const ControllerTest({super.key});

  @override
  State<ControllerTest> createState() => _ControllerTestState();
}

class _ControllerTestState extends State<ControllerTest> {
  final _controller = FooController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('控制器'),
      ),
      body: Column(
        children: [
          Foo(controller: _controller),
          ElevatedButton(
            onPressed: () {
              _controller.setMax();
            },
            child: Text('set to 100%'),
          ),
        ],
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
    return Container(
      color: Colors.red,
      child: ListenableBuilder(
        listenable: widget.controller,
        builder: (BuildContext context, Widget? child) {
          print('ListenableBuilder rebuild');
          return Column(
            children: [
              FlutterLogo(size: widget.controller.value * 100 + 50),
              Slider(
                value: widget.controller.value,
                onChanged: (double value) {
                  widget.controller.value = value;
                },
              )
            ],
          );
        },
      ),
    );
  }
}

class FooController extends ChangeNotifier {
  double _value = 0.5;

  double get value => _value;

  set value(double newValue) {
    _value = newValue;
    notifyListeners();
  }

  void setMax() {
    _value = 1.0;
    notifyListeners();
  }
}
