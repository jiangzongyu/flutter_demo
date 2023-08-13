import 'package:flutter/material.dart';

class SliversTest extends StatelessWidget {
  const SliversTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('走进Slivers的世界'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: FlutterLogo(size: 100),
          ),
          const SliverToBoxAdapter(
            child: FlutterLogo(size: 100),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 100,
                color: Colors.primaries[index % Colors.primaries.length],
              );
            }, childCount: 22),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 100,
                color: Colors.primaries[index % Colors.primaries.length],
              );
            }),
          ),
        ],
      ),
    );
  }
}
