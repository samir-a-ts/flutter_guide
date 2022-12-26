import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Places list page.
class PlacesListPage extends StatelessWidget {
  /// Initialization.
  const PlacesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, content) {
        return const Scaffold(
          body: Center(
            child: Text('Places list'),
          ),
        );
      },
    );
  }
}
