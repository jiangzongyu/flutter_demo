import 'package:flutter/material.dart';

class SliversTest2 extends StatelessWidget {
  const SliversTest2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('走进Slivers的世界2'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPrototypeExtentList(
            delegate: SliverChildListDelegate(
              [
                const Text('xxx'),
                const Text('xxx'),
                const Text('xxx'),
              ],
            ),
            prototypeItem: const Text(
              'xxx',
              style: TextStyle(fontSize: 32),
            ), // 按照出入的组件大小来规定 delegate 中组件的大小
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const FlutterLogo(),
                const FlutterLogo(
                  size: 220,
                ),
                const FlutterLogo(),
              ],
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(
              [
                const FlutterLogo(
                  size: 220, //此时设置大小 220 无效，因为 itemExtent 优先级高于配置高度
                ),
                const FlutterLogo(),
                const FlutterLogo(),
              ],
            ),
            itemExtent: 100,
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 100,
                color: Colors.primaries[index % Colors.primaries.length],
              );
            }, childCount: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
          ),
          // 与 pageView 一样
          SliverFillViewport(
            delegate: SliverChildListDelegate(
              [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
              ],
            ),
          )
        ],
      ),
    );
  }
}
