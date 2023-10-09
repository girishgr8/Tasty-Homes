// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';
// import 'package:supercharged/supercharged.dart';

// enum AniProps { opacity, translateX }

// class FadeIn extends StatelessWidget {
//   final double delay;
//   final Widget child;

//   FadeIn(this.delay, this.child);

//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTween`<AniProps>()
//       ..add(AniProps.opacity, 0.0.tweenTo(1.0))
//       ..add(AniProps.translateX, 130.0.tweenTo(0.0));

//     return PlayAnimationBuilder<TweenSequenceItem<AniProps>>(
//       delay: (300 * delay).round().milliseconds,
//       duration: 500.milliseconds,
//       tween: tween,
//       child: child,
//       builder: (context, child, value) => Opacity(
//         opacity: value.(AniProps.opacity),
//         child: Transform.translate(
//           offset: Offset(value.get(AniProps.translateX), 0),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
