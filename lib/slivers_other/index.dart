import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliversOther extends StatelessWidget {
  const SliversOther({super.key});

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
            title: Text('Slivers更多组件'),
            // pinned: true, // 一直出现导航
            snap: true,
            // 稍微向下滑动则出现导航蓝鸟
            floating: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(40.0),
            sliver: SliverIgnorePointer(
              ignoring: false,
              sliver: SliverToBoxAdapter(
                child: ElevatedButton(
                  child: FlutterLogo(size: 100),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildListDelegate(
              [
                const Icon(Icons.animation),
                const Icon(Icons.translate),
                const Icon(Icons.save),
                const Icon(Icons.person),
              ],
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 4,
              color: Colors.red,
            ),
          ),
          // 剩余空间的部分
          // const SliverFillRemaining(
          //   child: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // )
          SliverLayoutBuilder(
            builder: (BuildContext builer, SliverConstraints costraints) {
              print(costraints);
              return const SliverToBoxAdapter();
            },
          ),
          const SliverToBoxAdapter(
            child: Placeholder(fallbackHeight: 2000),
          )
        ],
      ),
    );
  }
}
