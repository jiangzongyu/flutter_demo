import 'package:flutter/material.dart';

class ScrollRefresh extends StatelessWidget {
  ScrollRefresh({super.key});

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('下拉&刷新'),
      ),
      // CupertinoScrollbar 在安卓上可以拖拽滚动条；ScrollBar 在安卓则不可以，ios拖拽滚动条则需要定义itemCount否则会crash
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        strokeWidth: 4.0,
        color: Colors.white,
        backgroundColor: Colors.black,
        child: Scrollbar(
          child: NotificationListener(
            onNotification: (notification) {
              print(notification);
              // 是否阻止事件向上冒泡，返回false则向上冒泡。为true则停止向上冒泡，停止向上冒泡则不执行RefreshIndicator 刷新操作
              return false;
            },
            child: ListView.builder(
              controller: _controller,
              itemCount: 100,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blue[index % 9 * 100],
                  height: 60,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
