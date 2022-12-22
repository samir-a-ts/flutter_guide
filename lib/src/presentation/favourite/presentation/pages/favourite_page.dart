import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  static const _text = "Favourites";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(_text),
      ),
    );
  }
}
