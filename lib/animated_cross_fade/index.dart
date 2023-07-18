import 'package:flutter/material.dart';

class AnimatedCrossFadeTest extends StatefulWidget {
  const AnimatedCrossFadeTest({super.key});

  @override
  State<AnimatedCrossFadeTest> createState() => _AnimatedCrossFadeTestState();
}

class _AnimatedCrossFadeTestState extends State<AnimatedCrossFadeTest> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCrossFadeTest'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: Center(
          child: AnimatedContainer(
            width: selected ? 200.0 : 100.0,
            height: selected ? 100.0 : 200.0,
            color: selected ? Colors.red : Colors.blue,
            alignment:
                selected ? Alignment.center : AlignmentDirectional.topCenter,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: const FlutterLogo(size: 75),
          ),
        ),
      ),
    );
  }
}
