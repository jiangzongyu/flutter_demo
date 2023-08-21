import 'package:flutter/material.dart';

class ChangeNotifierProvider<T extends Listenable> extends StatefulWidget {
  final Widget child;
  final T Function() create;

  const ChangeNotifierProvider({
    super.key,
    required this.child,
    required this.create,
  });

  @override
  State<ChangeNotifierProvider> createState() =>
      _ChangeNotifierProviderState<T>();

  static T of<T>(BuildContext context, {required bool listen}) {
    if (listen) {
      // 一直监听
      return context
          .dependOnInheritedWidgetOfExactType<_InheritedWidget<T>>()!
          .model;
    } else {
      // 只执行一次
      return context
          .getInheritedWidgetOfExactType<_InheritedWidget<T>>()!
          .model;
    }
  }
}

class _ChangeNotifierProviderState<T extends Listenable>
    extends State<ChangeNotifierProvider<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: model,
      builder: (BuildContext context, Widget? child) {
        return _InheritedWidget(
          model: model,
          child: widget.child,
        );
      },
    );
  }
}

class _InheritedWidget<T> extends InheritedWidget {
  final T model;

  const _InheritedWidget({
    super.key,
    required super.child,
    required this.model,
  });

  @override
  bool updateShouldNotify(covariant _InheritedWidget oldWidget) {
    return true;
  }
}

// 如果没有命名 Consumer 则只能在当前文件中使用（私有扩展），命名之后可以被其他文件使用
extension Consumer on BuildContext {
  T watch<T>() => ChangeNotifierProvider.of(this, listen: true);

  T read<T>() => ChangeNotifierProvider.of(this, listen: false);
}
