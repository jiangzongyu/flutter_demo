import 'package:flutter/material.dart';

class PageViewTest extends StatelessWidget {
  const PageViewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView'),
      ),
      // ListWheelScrollView 不支持横向滚动，如果想要横向滚动的话需要包一层 RotatedBox 里面的内容再包一层 RotatedBox
      body: PageView(
        // pageSnapping: false, // 默认为 true 停留在某个页面，为 false 时可以停留在任何位置
        scrollDirection: Axis.vertical, // 竖着滑动
        onPageChanged: (index) => print("selected $index"),
        children: [
          Container(color: Colors.blue),
          Container(color: Colors.orange),
        ],
      ),
    );
  }
}
