import 'animated_builder/index.dart';
import 'animated_container/index.dart';
import 'animated_cross_fade/index.dart';
import 'animated_padding/index.dart';
import 'animated_switcher/index.dart';
import 'breathing_animation/index.dart';
import 'custom_drag_game/index.dart';
import 'custom_painter/index.dart';
import 'dismissible/index.dart';
import 'dynamic_state/index.dart';
import 'future/index.dart';
import 'future_builder/index.dart';
import 'grid_view/index.dart';
import 'hero/index.dart';
import 'input_game/index.dart';
import 'interlace_animation/index.dart';
import 'list_view/index.dart';
import 'list_wheel/index.dart';
import 'page_view/index.dart';
import 'reorderable_list_view/index.dart';
import 'rive/index.dart';
import 'rotation_fade_opacity/index.dart';
import 'rotation_transition/index.dart';
import 'scroll_num/index.dart';
import 'scroll_refresh/index.dart';
import 'single_child_scroll_view/index.dart';
import 'slide_transition/index.dart';
import 'stream/index.dart';
import 'tween_animation_builder/index.dart';
import 'ultimate_drag_game/index.dart';

List routerList = [
  {
    'name': 'AnimatedContainer',
    'method': const AnimatedContainerTest(),
  },
  {
    'name': 'AnimatedSwitcher',
    'method': const AnimatedSwitcherTest(),
  },
  {
    'name': 'AnimatedCrossFade',
    'method': const AnimatedCrossFadeTest(),
  },
  {
    'name': 'AnimatedPadding',
    'method': const AnimatedPaddingTest(),
  },
  {
    'name': 'TweenAnimationBuilder',
    'method': const TweenAnimationBuilderTest(),
  },
  {
    'name': 'scrollNum示例',
    'method': const ScrollNum(),
  },
  {
    'name': 'RotationTransition',
    'method': const RotationTransitionTest(),
  },
  {
    'name': 'Rotation/Fade/Opacity',
    'method': const TransitionTest(),
  },
  {
    'name': 'SlideTransition',
    'method': const SlideTransitionTest(),
  },
  {
    'name': '交错动画',
    'method': const InterlaceAnimation(),
  },
  {
    'name': 'AnimatedBuilder',
    'method': const AnimatedBuilderTest(),
  },
  {
    'name': '478呼吸动画',
    'method': const BreathingAnimation(),
  },
  {
    'name': 'Hero',
    'method': const HeroTest(),
  },
  {
    'name': 'CustomPainter&雪人',
    'method': const CustomPainterTest(),
  },
  {
    'name': 'rive插件',
    'method': const RiveTest(),
  },
  {
    'name': 'ReorderableListView拖拽颜色',
    'method': const ReorderableListViewTest(),
  },
  {
    'name': '自定义拖拽颜色游戏',
    'method': const CustomDrag(),
  },
  {
    'name': '终极版拖拽颜色游戏',
    'method': const UltimateDrag(),
  },
  {
    'name': 'ListView',
    'method': ListViewTest(),
  },
  {
    'name': '下拉&刷新',
    'method': ScrollRefresh(),
  },
  {
    'name': 'dismissible',
    'method': const DismissibleTest(),
  },
  {
    'name': 'GitHub最新动态',
    'method': const DynamicState(),
  },
  {
    'name': 'GridViewTest',
    'method': const GridViewTest(),
  },
  {
    'name': 'ListWheelScrollView',
    'method': const ListWheel(),
  },
  {
    'name': 'PageView',
    'method': const PageViewTest(),
  },
  {
    'name': 'SingleChildScrollView',
    'method': const SingleChildScrollViewTest(),
  },
  {
    'name': 'Future事件循环机制',
    'method': const FutureTest(),
  },
  {
    'name': 'FutureBuilder',
    'method': const FutureBuilderTest(),
  },
  {
    'name': 'Stream',
    'method': const StreamTest(),
  },
  {
    'name': 'Stream输入数字游戏',
    'method': const InputGame(),
  }
];
