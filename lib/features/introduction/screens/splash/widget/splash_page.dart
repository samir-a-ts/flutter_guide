import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/features/navigation/service/app_router.gr.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Splash page
class SplashPage extends StatefulWidget {
  /// Constructor for [SplashPage]
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        AutoRouter.of(context).replace(
          const TutorialRoute(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.of(context).yellowColor,
              Theme.of(context).primaryColor,
            ],
            begin: const Alignment(-1, .1),
            end: const Alignment(1, -.1),
          ),
        ),
        child: Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 1, end: 0),
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(-value * 50, -value * 25),
                child: Transform.rotate(
                  angle: value * (pi / 2),
                  child: Transform.scale(
                    scale: 0.8 + (0.2 * (1 - value)),
                    child: child,
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 160.sm,
            ),
          ),
        ),
      ),
    );
  }
}
