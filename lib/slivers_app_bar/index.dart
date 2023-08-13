import 'package:flutter/material.dart';

class SliversAppBarTest extends StatelessWidget {
  const SliversAppBarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('SliversAppBar'),
      // ),
      // 与 appBar 大致类似
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('SliversAppBar'),
            // pinned: true, // 一直出现导航
            snap: true,
            // 稍微向下滑动则出现导航蓝鸟
            floating: true,
            // 向下滑动出现导航
            expandedHeight: 200,
            stretch: true,
            // stretchModes 想要生效需要配置 stretch 为 true
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterLogo(),
              title: Text(
                'FlexibleSpaceBar title',
                style: TextStyle(color: Colors.blue),
              ),
              // collapseMode: CollapseMode.none, // 向上移动 appBar 样式，用默认即可
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
            ),
          ),
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
