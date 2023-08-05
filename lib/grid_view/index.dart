import 'package:flutter/material.dart';

class GridViewTest extends StatefulWidget {
  const GridViewTest({super.key});

  @override
  State<GridViewTest> createState() => _GridViewTestState();
}

class _GridViewTestState extends State<GridViewTest> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size); // iphone 14 max size: (430.0, 932.0)
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridViewTest'),
      ),
      body: GridView.builder(
        // 以 16 / 9 的比例展示 4 个，但是横屏的时候也展示4个，正常逻辑是横屏的时候展示更多
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 4,
        //   childAspectRatio: 16 / 9,
        // ),
        // 横屏展示更多
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          // 以竖屏举例：最大展示宽度 140 只能展示 4 个, 为 100 的时候只能展示 5 个
          maxCrossAxisExtent: 100,
          childAspectRatio: 16 / 9,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 2.0,
          mainAxisExtent: 100, // 竖向高度 优先级大于 childAspectRatio
        ),
        itemBuilder: (_, index) => Container(
          color: Colors.blue[index % 8 * 100],
        ),
      ),
    );
  }
}

/**
 * GridView.count() 类似 SliverGridDelegateWithFixedCrossAxisCount 但是不支持 itemBuilder
 * GridView.extent() 类似 SliverGridDelegateWithMaxCrossAxisExtent 但是不支持 itemBuilder
 */
