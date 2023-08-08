import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class InputGame extends StatefulWidget {
  const InputGame({super.key});

  @override
  State<InputGame> createState() => _InputGameState();
}

class _InputGameState extends State<InputGame> {
  final StreamController<int> _inputController = StreamController.broadcast();
  final StreamController<int> _scoreController = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _scoreController.stream.transform(TallyTransformer()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Score: ${snapshot.data}');
            }
            return Text('Score: 0');
          },
        ),
      ),
      body: Stack(
        children: [
          ...List.generate(
            5,
            (index) => Puzzle(
              inputStream: _inputController.stream,
              scoreStream: _scoreController,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyPad(
              inputController: _inputController,
              scoreController: _scoreController,
            ),
          ),
        ],
      ),
    );
  }
}

class TallyTransformer implements StreamTransformer<int, dynamic> {
  int sum = 0;
  final StreamController _controller = StreamController();

  @override
  Stream bind(Stream stream) {
    stream.listen((event) {
      sum += event as int;
      _controller.add(sum);
    });
    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}

class Puzzle extends StatefulWidget {
  final Stream<int> inputStream;
  final StreamController<int> scoreStream;

  const Puzzle(
      {super.key, required this.inputStream, required this.scoreStream});

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  late int a, b;
  double? x;
  Color? color;

  late final AnimationController _controller;

  reset([form = 0.0]) {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextDouble() * 300;
    _controller.duration =
        Duration(milliseconds: Random().nextInt(5000) + 10000);
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)][200];

    _controller.forward(from: form);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    reset(Random().nextDouble());
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        widget.scoreStream.add(-3);
      }
    });

    widget.inputStream.listen((int event) {
      if (event == a + b) {
        reset();
        widget.scoreStream.add(5);
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
              color: color?.withOpacity(0.5),
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
  final StreamController inputController;
  final StreamController scoreController;

  const KeyPad({
    super.key,
    required this.inputController,
    required this.scoreController,
  });

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
            inputController.add(index + 1);
            scoreController.add(-2);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.primaries[index][200],
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(
            "${index + 1}",
            style: const TextStyle(fontSize: 24, color: Colors.black),
          ),
        );
      }),
    );
  }
}
