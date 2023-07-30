import 'package:flutter/material.dart';

class ListViewTest extends StatelessWidget {
  ListViewTest({super.key});

  final _controller = ScrollController();

  _incrementCounter() {
    print(_controller.position);
    _controller.animateTo(
      _controller.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _controller.animateTo(
              -20.0,
              duration: const Duration(seconds: 1),
              curve: Curves.linear,
            );
          },
          child: const Text('ListViewTest'),
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          // physics: AlwaysScrollableScrollPhysics(),
          /**
           * physics 是否有回弹效果
           * 1. ClampingScrollPhysics() 无回弹效果类似安卓
           * 2. BouncingScrollPhysics() 有回弹效果类似ios
           * 3. NeverScrollableScrollPhysics 无法滚动但是可以点击appBar和向下箭头滚动
           * 4. AlwaysScrollableScrollPhysics 永远可以滚动
           */
          controller: _controller,
          padding: const EdgeInsets.only(bottom: 100),
          // 滑动过程中没有padding只有到底部的时候会有
          itemCount: 50,
          // cacheExtent: 30, // 缓存底部预出现多少高度
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: const Text('subtitle'),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {},
              ),
            );
          },
        ),
      ),
      // 存在分割线
      // body: ListView.separated(
      //   itemBuilder: (context, index) {
      //     return Container(
      //       height: 60,
      //       alignment: Alignment.center,
      //       child: Text('$index'),
      //     );
      //   },
      //   separatorBuilder: (context, index) {
      //     if (index == 0) {
      //       return const Divider(thickness: 4);
      //     }
      //     return const Divider();
      //   },
      //   itemCount: 50,
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'down',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}
