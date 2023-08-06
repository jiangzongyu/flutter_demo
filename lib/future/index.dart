import 'dart:async';

import 'package:flutter/material.dart';

class FutureTest extends StatelessWidget {
  const FutureTest({super.key});

  /// 运行结果
  /// init 1
  /// sync 1
  /// get name
  /// init 2
  /// microtask 1
  /// microtask 2
  /// microtask 3
  /// event 1
  /// event 2
  /// event 3
  /// event 4
  /// then 1
  /// then 2
  /// event 4 microtask
  init() {
    Future.delayed(const Duration(seconds: 1), () => debugPrint('event 3'));
    Future(() => debugPrint('event 1'));
    // 延迟 Duration.zero 和不写效果一样 类似 setTimeout 时间传入为 0
    Future.delayed(
      Duration.zero,
      () => debugPrint('event 2'),
    );
    // then里面的会立即执行，不会进入到微任务队列中
    Future.delayed(const Duration(seconds: 2), () => debugPrint('event 4'))
        .then((value) {
      scheduleMicrotask(() => debugPrint('event 4 microtask'));
    }).then((value) => debugPrint('then 2'));

    scheduleMicrotask(() => debugPrint('microtask 1'));
    Future.microtask(() => debugPrint('microtask 2'));
    Future.value(123).then((value) => debugPrint('microtask 3'));

    Future.sync(() => debugPrint('sync 1'));
    Future.value(getName());
  }

  getName() {
    return 'getName';
  }

  Future<String> getFuture() {
    // return Future.error(Exception('something went wrong'));
    return Future.value('123');
  }

  void runGetFuture() {
    getFuture()
        .then((value) {
          print(value);
          return '222';
        })
        .then((value) => print(value))
        .catchError((err) => print(err))
        .whenComplete(() => print('complete'));
  }

  // Future<int> 也可以省略
  Future<int> getFuture2() async {
    throw 'oops';
    // return 100;
  }

  void runGetFuture2() async {
    // 第一种获取方法
    // Future<int> id = getFuture2();
    // id.then((value) => print(value * 2));

    // 第二种过去方法
    // int id = await getFuture2();
    // id *= 2;
    // print(id);

    // 第三种获取方法
    try {
      int id = await getFuture2();
      id *= 2;
      print(id);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    // init();
    // runGetFuture();
    runGetFuture2();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future事件循环机制'),
      ),
      // ListWheelScrollView 不支持横向滚动，如果想要横向滚动的话需要包一层 RotatedBox 里面的内容再包一层 RotatedBox
      body: const Center(
        child: Text('Future'),
      ),
    );
  }
}
