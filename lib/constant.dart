import './animated_container/index.dart';
import './animated_switcher/index.dart';
import './animated_cross_fade/index.dart';
import './animated_padding/index.dart';
import './tween_animation_builder/index.dart';

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
  }
];
