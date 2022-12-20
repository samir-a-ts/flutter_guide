import 'package:flutter/material.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({super.key});

  static const _text = "Look at me!";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(_text),
      ),
    );
  }
}
