import 'dart:async';

import 'package:flutter/material.dart';

class StreamTest extends StatefulWidget {
  const StreamTest({super.key});

  @override
  State<StreamTest> createState() => _StreamTestState();
}

class _StreamTestState extends State<StreamTest> {
  final future = Future.delayed(const Duration(seconds: 1), () => 40);
  final stream = Stream.periodic(const Duration(seconds: 1), (_) => 42);

  final controller = StreamController.broadcast();

  @override
  void initState() {
    // future.then((value) => print('future completed with value: $value'));
    // stream.listen((event) {
    //   print('stream: $event');
    // });

    /// 因为 StreamBuilder 中 steam 已经监听了，如果还想监听则则需要进行广播方式即将 StreamController() 更换为 StreamController.broadcast()
    /// 但是广播的数据流没有缓存
    Future.delayed(const Duration(seconds: 5), () {
      controller.stream.listen(
        (event) {
          print('event: $event');
        },
        onError: (err) => print('err: $err'),
        onDone: () => print('done'),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  Future<int> getId() async {
    return 5;
  }

  // 打印时间
  Stream<DateTime> getTime() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream&StreamBuilder'),
      ),
      body: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headlineLarge ?? const TextStyle(),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => controller.sink.add(10),
                child: const Text('10'),
              ),
              ElevatedButton(
                onPressed: () => controller.sink.add(1),
                child: const Text('1'),
              ),
              ElevatedButton(
                onPressed: () => controller.sink.add('Hi'),
                child: const Text('Hi'),
              ),
              ElevatedButton(
                onPressed: () => controller.sink.addError("oops"),
                child: const Text('Error'),
              ),
              ElevatedButton(
                onPressed: () => controller.sink.close(),
                child: const Text('Close'),
              ),
              StreamBuilder(
                // stream: getTime(),
                stream: controller.stream
                    .where((event) => event is int) // 类似 js 中 filter
                    .map((event) => event * 2)
                    .distinct(),
                // 去重，如果按相同的按钮就不用重新 build，否则 print('building') 会点击相同按钮也会打印
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  print('building');
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('none: 没有数据流');
                    case ConnectionState.waiting:
                      return const Text('waiting: 等待数据流');
                    case ConnectionState.active:
                      if (snapshot.hasError) {
                        return Text('active: 错误: ${snapshot.error}');
                      } else {
                        return Text('active: 正常: ${snapshot.data}');
                      }
                    case ConnectionState.done:
                      return const Text('done: 数据流已经关闭');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
