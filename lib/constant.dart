import './animated_container/index.dart';
import './animated_switcher/index.dart';
import './animated_cross_fade/index.dart';
import './animated_padding/index.dart';
import './tween_animation_builder/index.dart';
import './scroll_num/index.dart';
import './rotation_transition/index.dart';
import './rotation_fade_opacity/index.dart';
import './slide_transition/index.dart';
import './interlace_animation/index.dart';
import './animated_builder/index.dart';

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
  }
];
