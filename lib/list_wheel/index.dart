import 'package:flutter/material.dart';

class ListWheel extends StatelessWidget {
  const ListWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListWheelScrollView'),
      ),
      // ListWheelScrollView 不支持横向滚动，如果想要横向滚动的话需要包一层 RotatedBox 里面的内容再包一层 RotatedBox
      body: RotatedBox(
        quarterTurns: 1, // 四分之一圈
        child: ListWheelScrollView(
          itemExtent: 100,
          // offAxisFraction: 1.2, // 轴心便宜整数向左，负数向右
          // diameterRatio: 0.8, // 直径比例
          overAndUnderCenterOpacity: 0.5,
          // 上下透明度
          // magnification: 2.5, // 放大镜中间比较大
          // useMagnifier: true, // 如果不使用 overAndUnderCenterOpacity 则需要配置此字段
          physics: const FixedExtentScrollPhysics(),
          // NeverScrollableScrollPhysics 无法滚动; FixedExtentScrollPhysics 保证滚动停留在哪个位置
          onSelectedItemChanged: (index) => print("select $index"),
          children: List.generate(
            10,
            (index) => RotatedBox(
              quarterTurns: -1,
              child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  "$index",
                  style: const TextStyle(fontSize: 50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
