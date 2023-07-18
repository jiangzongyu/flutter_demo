import 'package:flutter/material.dart';

import './animated_container/index.dart';

class RouterManager {
  Map<String, WidgetBuilder> _routerMap = <String, WidgetBuilder>{};

  RouterManager() {
    _routerMap = <String, WidgetBuilder>{
      'animatedContainerTest': (BuildContext context) =>
          const AnimatedContainerTest(),
    };
  }

  // 获取初始化后的展示页面
  Widget getInitPage(BuildContext context) {
    // DOTO：LS判断是否是第一次
    return _routerMap['picWall']!(context);
    // return _routerMap['guideIndex']!(context);
  }

  Map<String, WidgetBuilder> getRouter() {
    return _routerMap;
  }
}
