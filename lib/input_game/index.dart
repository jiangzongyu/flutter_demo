import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class InputGame extends StatefulWidget {
  const InputGame({super.key});

  @override
  State<InputGame> createState() => _InputGameState();
}

class _InputGameState extends State<InputGame> {
  final StreamController<int> _controller = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('${snapshot.data}');
            }
            return Text('waitting');
          },
        ),
      ),
      body: Stack(
        children: [
          ...List.generate(
            5,
            (index) => Puzzle(inputStream: _controller.stream),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyPad(controller: _controller),
          ),
        ],
      ),
    );
  }
}

class Puzzle extends StatefulWidget {
  final Stream<int> inputStream;

  const Puzzle({super.key, required this.inputStream});

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  late int a, b;
  double? x;
  Color? color;

  late final AnimationController _controller;

  reset() {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextDouble() * 300;
    _controller.duration =
        Duration(milliseconds: Random().nextInt(5000) + 5000);
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)][200];
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..forward();
    reset();
    _controller.forward(from: Random().nextDouble());
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        _controller.forward(from: 0.0);
      }
    });

    widget.inputStream.listen((int event) {
      if (event == a + b) {
        reset();
        _controller.forward(from: 0.0);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          left: x,
          top: _controller.value * 800 - 100,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              '$a + $b',
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    );
  }
}

// 键盘
class KeyPad extends StatelessWidget {
  final StreamController controller;

  const KeyPad({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2 / 1,
      // shrinkWrap 真空包装不占满整个屏幕
      shrinkWrap: true,
      // ios 底部 bar 的区域，我们不需要底部区域所以需要额外设置为 0
      padding: const EdgeInsets.all(0.0),
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(9, (index) {
        return TextButton(
          onPressed: () {
            controller.add(index + 1);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.primaries[index][200],
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(
            "${index + 1}",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        );
      }),
    );
  }
}
