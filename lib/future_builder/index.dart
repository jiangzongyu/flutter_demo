import 'package:flutter/material.dart';

class FutureBuilderTest extends StatelessWidget {
  const FutureBuilderTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder'),
      ),
      // ListWheelScrollView 不支持横向滚动，如果想要横向滚动的话需要包一层 RotatedBox 里面的内容再包一层 RotatedBox
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2), () => 123),
          // future: Future.delayed(Duration(seconds: 2), () => throw ('oops')),
          // 如果存在 snapshot.connectionState == ConnectionState.waiting 这个判断则该字段不生效。只存在 snapshot.hasData 且不存在 snapshot.connectionState == ConnectionState.waiting 时生效
          initialData: 100,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // 第一种容易写成金字塔结构
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const CircularProgressIndicator();
            // }
            // if (snapshot.connectionState == ConnectionState.done) {
            //   if (snapshot.hasError) {
            //     return const Icon(
            //       Icons.error,
            //       size: 80,
            //     );
            //   }
            //   return Text(
            //     "${snapshot.data}",
            //     style: const TextStyle(fontSize: 72),
            //   );
            // }
            // throw "should not happen";
            //   第二种写法
            if (snapshot.hasError) {
              print("${snapshot.error}");
              return const Icon(
                Icons.error,
                size: 80,
              );
            }
            if (snapshot.hasData) {
              return Text(
                "${snapshot.data}",
                style: const TextStyle(fontSize: 72),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
