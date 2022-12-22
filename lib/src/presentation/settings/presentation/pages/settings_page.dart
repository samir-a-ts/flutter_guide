import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _text = "Settings";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(_text),
      ),
    );
  }
}
