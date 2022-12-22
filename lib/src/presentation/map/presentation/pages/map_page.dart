import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static const _text = "Map";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(_text),
      ),
    );
  }
}
