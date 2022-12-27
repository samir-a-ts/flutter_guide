import 'dart:math';

import 'package:flutter/material.dart';

/// Progress indicator app-styled.
class AppProgressIndicator extends StatefulWidget {
  /// Initialization.
  const AppProgressIndicator({super.key});

  @override
  State<AppProgressIndicator> createState() => _AppProgressIndicatorState();
}

class _AppProgressIndicatorState extends State<AppProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Image.asset(
        'assets/images/loader.png',
        width: 30,
        height: 30,
      ),
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * (pi * 4),
          child: child,
        );
      },
    );
  }
}
