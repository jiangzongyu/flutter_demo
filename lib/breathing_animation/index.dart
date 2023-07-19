import 'package:flutter/material.dart';

class BreathingAnimation extends StatefulWidget {
  const BreathingAnimation({Key? key}) : super(key: key);

  @override
  State<BreathingAnimation> createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<BreathingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _expansionController;
  late AnimationController _opacityController;

  @override
  void initState() {
    _opacityController = AnimationController(vsync: this);
    _expansionController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _expansionController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  void _incrementCounter() async {
    _expansionController.duration = const Duration(seconds: 4);
    _expansionController.forward();
    await Future.delayed(const Duration(seconds: 4));

    _opacityController.duration = const Duration(milliseconds: 1750);
    _opacityController.repeat(reverse: true);
    await Future.delayed(const Duration(seconds: 7));
    _opacityController.reset();

    _expansionController.duration = const Duration(seconds: 8);
    _expansionController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('478呼吸动画'),
      ),
      body: Center(
        child: FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.5).animate(_opacityController),
          child: AnimatedBuilder(
            animation: _expansionController,
            builder: (BuildContext context, Widget? child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue[600]!,
                      Colors.blue[100]!,
                    ],
                    stops: [
                      _expansionController.value,
                      _expansionController.value + 0.1
                    ],
                  ),
                ),
              );
            },
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
