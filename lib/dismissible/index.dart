import 'package:flutter/material.dart';

class DismissibleTest extends StatelessWidget {
  const DismissibleTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DismissibleTest'),
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (_, index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              print(direction);
              if (direction == DismissDirection.startToEnd) {
                print('phone');
              }
            },
            confirmDismiss: (direction) async {
              // 等1s中然后删除，返回false则不删除
              await Future.delayed(const Duration(seconds: 1));
              return true;
            },
            onResize: () {
              // 消失持续打印
              print('resize');
            },
            resizeDuration: const Duration(seconds: 2),
            // resizeDuration 滑动消失时长
            movementDuration: const Duration(seconds: 5),
            // movementDuration 默认滑动超过40%则判定滑动成功
            dismissThresholds: const {
              DismissDirection.startToEnd: 0.1,
              DismissDirection.endToStart: 0.9,
            },
            // dismissThresholds 修改滑动距离从左滑动百分比 0.1 的距离，从右向左滑动百分比 0.9 的距离
            background: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(24),
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.phone),
            ),
            secondaryBackground: Container(
              color: Colors.black,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 24),
              child: const Icon(
                Icons.sms,
                color: Colors.white,
              ),
            ),
            child: Container(
              height: 72,
              color: Colors.blue[index % 9 * 100],
            ),
          );
        },
      ),
    );
  }
}
