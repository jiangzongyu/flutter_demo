import 'package:flutter/material.dart';

// 使用不太多主要用 ChangeNotifier 比较多，简单了解 ValueNotifier 即可
class InheritedWidgetTest extends StatefulWidget {
  const InheritedWidgetTest({super.key});

  @override
  State<InheritedWidgetTest> createState() => _InheritedWidgetTestState();
}

class _InheritedWidgetTestState extends State<InheritedWidgetTest> {
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedWidgetTest'),
      ),
      body: MyColor(
        color: Colors.black,
        child: Center(
          child: MyColor(
            color: _color,
            child: Foo(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _color = Colors.red;
          });
        },
        tooltip: 'Clear',
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}

class Foo extends StatelessWidget {
  const Foo({super.key});

  @override
  Widget build(BuildContext context) {
    print('Foo build');
    // final myColor = context.dependOnInheritedWidgetOfExactType<MyColor>();
    return Container(
      width: 200,
      height: 200,
      // color: myColor?.color,
      // color: MyColor.of(context).color,
      color: MyColor.maybeOf(context)?.color,
    );
  }
}

// 向上找离自己最近的颜色
class MyColor extends InheritedWidget {
  final Color color;

  const MyColor({super.key, required super.child, required this.color});

  static MyColor? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyColor>();
  }

  static MyColor of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyColor>()!;
  }

  @override
  bool updateShouldNotify(covariant MyColor oldWidget) {
    return oldWidget.color != color;
  }
}

/// 总结
/// InheritedWidget 向上找离自己最近的
/// InheritedModel 继承于 InheritedWidget

class MyColor1 extends InheritedModel {
  final Color color;
  final double width;

  const MyColor1({
    super.key,
    required super.child,
    required this.color,
    required this.width,
  });

  @override
  bool updateShouldNotify(covariant MyColor1 oldWidget) {
    return true;
  }

  @override
  // 这里针对特定条件进一步判断是否更新；例如有多个变量的时候，我只是针对 color 改变的时候更新，而 width 改变的时候不更新
  bool updateShouldNotifyDependent(
      covariant MyColor1 oldWidget, Set dependencies) {
    if (dependencies.contains('color')) {
      return true;
    }
    return false;
  }
}
