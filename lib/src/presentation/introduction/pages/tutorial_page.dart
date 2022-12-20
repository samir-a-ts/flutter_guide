import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/router/app_router.gr.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  static const _title = "This app do stuff, you know?";

  static const _bottomButtonText = "LETS GOOO";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(_title),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        height: 64,
        child: Center(
          child: TextButton(
            onPressed: () {
              AutoRouter.of(context).replace(const PlacesListRoute());
            },
            child: const Text(_bottomButtonText),
          ),
        ),
      ),
    );
  }
}
