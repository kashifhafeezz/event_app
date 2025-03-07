import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

enum AniProps { opacity, translateX }

class FadeAnimation extends StatelessWidget {
  const FadeAnimation({
    required this.child,
    required this.delay,
    super.key,
    this.beginPointOnY = -30,
  });
  final double delay;
  final Widget child;
  final double beginPointOnY;

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        'opacity',
        Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      )
      ..tween(
        'translateY',
        duration: const Duration(milliseconds: 500),
        Tween<double>(begin: beginPointOnY, end: 0),
        curve: Curves.easeOut,
      );

    return CustomAnimationBuilder(
      delay: Duration(
        milliseconds:
            (50 * delay > 1500 ? (1 * delay).round() : (100 * delay).round()),
      ),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (BuildContext context, Movie value, Widget? child) {
        return Opacity(
          opacity: double.parse(value.get<double>('opacity').toString()),
          child: Transform.translate(
            offset: Offset(
              0,
              double.parse(value.get<double>('translateY').toString()),
            ),
            child: child,
          ),
        );
      },
    );
  }
}

class FadePositionAnimation extends StatelessWidget {
  const FadePositionAnimation({
    required this.delay,
    required this.child,
    super.key,
    this.begin = -100.0,
  });

  final double delay;
  final Widget child;
  final double begin;

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        AniProps.opacity,
        Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 200),
      )
      ..tween(
        'translateX',
        Tween<double>(begin: begin, end: 0),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInSine,
      );

    return CustomAnimationBuilder(
      delay: Duration(
        milliseconds: (delay * 50 > 1000 ? delay : delay * 50).round(),
      ),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (BuildContext context, Movie value, Widget? child) => Opacity(
        opacity: value.get<double>(AniProps.opacity),
        child: Transform.translate(
          offset: Offset(
            value.get<double>('translateX'),
            0,
          ),
          child: child,
        ),
      ),
    );
  }
}
