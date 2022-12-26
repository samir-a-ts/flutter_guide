import 'package:flutter/widgets.dart';

/// Empty container for adding
/// space between sequence of widgets
/// without [Padding]
class Gap extends StatelessWidget {
  /// Width and height of this [Gap].
  final double dimension;

  /// Initialization.
  const Gap({
    required this.dimension,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
    );
  }
}
