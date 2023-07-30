import './animated_builder/index.dart';
import './animated_container/index.dart';
import './animated_cross_fade/index.dart';
import './animated_padding/index.dart';
import './animated_switcher/index.dart';
import './breathing_animation/index.dart';
import './custom_drag_game/index.dart';
import './custom_painter/index.dart';
import './hero/index.dart';
import './interlace_animation/index.dart';
import './reorderable_list_view/index.dart';
import './rive/index.dart';
import './rotation_fade_opacity/index.dart';
import './rotation_transition/index.dart';
import './scroll_num/index.dart';
import './slide_transition/index.dart';
import './tween_animation_builder/index.dart';
import './ultimate_drag_game/index.dart';

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
    'name': 'ReorderableListView拖拽颜色游戏',
    'method': const ReorderableListViewTest(),
  },
  {
    'name': '自定义拖拽颜色游戏',
    'method': const CustomDrag(),
  },
  {
    'name': '终极版拖拽颜色游戏',
    'method': const UltimateDrag(),
  }
];
