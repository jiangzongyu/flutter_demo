import 'package:flutter/material.dart';

class TweenAnimationBuilderTest extends StatefulWidget {
  const TweenAnimationBuilderTest({Key? key}) : super(key: key);

  @override
  State<TweenAnimationBuilderTest> createState() =>
      _TweenAnimationBuilderTestState();
}

class _TweenAnimationBuilderTestState extends State<TweenAnimationBuilderTest> {
  bool _big = true;

  void _incrementCounter() {
    setState(() {
      _big = !_big;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 1),
          // tween: Tween(begin: 1.0, end: 1.5), // scale
          // tween: Tween(begin: 0.0, end: 6.28), // rotate 0 ~ 6.28
          // tween: Tween(
          //   begin: const Offset(0.0, -10.0),
          //   end: const Offset(20.0, 0.0),
          // ), // rotate 0 ~ 6.28
          tween: Tween(end: _big ? 50.0 : 70.0),
          builder: (context, value, child) {
            return Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: Center(
                // 缩放Transform的构造函数scale
                // child: Transform.scale(
                //   scale: value,
                //   child: const Text(
                //     'Hello',
                //     style: TextStyle(fontSize: 50),
                //   ),
                // ),
                // 旋转
                // child: Transform.rotate(
                //   angle: value,
                //   child: const Text(
                //     'Hello',
                //     style: TextStyle(fontSize: 50),
                //   ),
                // ),
                // 平移
                // child: Transform.translate(
                //   offset: value,
                //   child: const Text(
                //     'Hello',
                //     style: TextStyle(fontSize: 50),
                //   ),
                // ),
                child: Center(
                  child: Text(
                    'Hello',
                    style: TextStyle(fontSize: value),
                  ),
                ),
              ),
            );
          },
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
