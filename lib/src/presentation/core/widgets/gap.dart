import 'package:flutter/cupertino.dart';

class Gap extends StatelessWidget {
  final double dimension;

  const Gap({
    super.key,
    required this.dimension,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
    );
  }
}
