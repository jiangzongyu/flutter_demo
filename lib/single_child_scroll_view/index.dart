import 'package:flutter/material.dart';

class SingleChildScrollViewTest extends StatelessWidget {
  const SingleChildScrollViewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListWheelScrollView'),
      ),
      /**
       * SingleChildScrollView 性能不好 需要 layout 两次
       * 与 ListView 不同的是如果内容高度没有超如屏幕高度则不会有滑动效果，超出则会有滚动效果
       * 而 ListView 都会有滚动效果
       */
      body: const SingleChildScrollView(
        child: Column(
          children: [
            FlutterLogo(size: 200),
            FlutterLogo(size: 300),
          ],
        ),
      ),
    );
  }
}
