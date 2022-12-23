import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, content) {
        return const Scaffold(
          body: Center(
            child: Text("Places list"),
          ),
        );
      },
    );
  }
}
