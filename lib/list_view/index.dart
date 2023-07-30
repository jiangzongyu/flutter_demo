import 'package:flutter/material.dart';

class ListViewTest extends StatelessWidget {
  const ListViewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListViewTest'),
      ),
      // body: ListView.builder(
      //   itemCount: 50,
      //   // cacheExtent: 30, // 缓存底部预出现多少高度
      //   itemBuilder: (context, index) {
      //     return Container(
      //       height: 60,
      //       alignment: Alignment.center,
      //       child: Text('$index'),
      //     );
      //   },
      // ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            height: 60,
            alignment: Alignment.center,
            child: Text('$index'),
          );
        },
        separatorBuilder: (context, index) {
          if (index == 0) {
            return const Divider(thickness: 4);
          }
          return const Divider();
        },
        itemCount: 50,
      ),
    );
  }
}
