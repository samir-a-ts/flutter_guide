import 'package:flutter/material.dart';
import 'package:flutter_guide/features/app/di/app_scope.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope.dart';
import 'package:provider/provider.dart';

/// Provides its [child]
/// with [IPlacesListScope]
class PlacesListScopeWidget extends StatelessWidget {
  /// Where the [IPlacesListScope]
  /// can be accessed.
  final Widget child;

  /// Constructor for [PlacesListScopeWidget]
  const PlacesListScopeWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<IPlacesListScope>(
      create: (context) {
        final appScope = Provider.of<IAppScope>(context, listen: false);

        return PlacesListScope(
          appScope.dio,
          appScope.sharedPreferences,
        );
      },
      child: child,
    );
  }
}
