import 'package:flutter/material.dart';

class AnimatedContainerTest extends StatefulWidget {
  const AnimatedContainerTest({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerTest> createState() => _AnimatedContainerTestState();
}

class _AnimatedContainerTestState extends State<AnimatedContainerTest> {
  double _height = 200;

  void _incrementCounter() {
    setState(() {
      _height += 100.0;
      if (_height > 400) _height = 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer'),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: 200,
              height: _height,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Hello',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.red, Colors.white],
                  stops: [0.2, 0.3],
                ),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 5,
                    blurRadius: 25,
                  ),
                ],
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
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
