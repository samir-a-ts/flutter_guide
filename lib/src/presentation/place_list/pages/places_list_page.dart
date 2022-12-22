import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({super.key});

  static const _text = "Places list";

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, content) => const Scaffold(
        body: Center(
          child: Text(_text),
        ),
      ),
    );
  }
}
