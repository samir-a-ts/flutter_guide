import 'package:flutter/widgets.dart';
import 'package:flutter_guide/features/app/di/app_scope.dart';
import 'package:flutter_guide/features/map/di/map_scope.dart';
import 'package:provider/provider.dart';

/// Propagates instance of
/// [IMapScope] to given [child]
/// via [Provider].
class MapScopeWidget extends StatelessWidget {
  /// Where the [IMapScope] will be
  /// accessed.
  final Widget child;

  /// Constructor for [MapScopeWidget]
  const MapScopeWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<IMapScope>(
      create: (context) {
        final appScope = Provider.of<IAppScope>(context, listen: false);

        return MapScope(appScope.dio);
      },
      child: child,
    );
  }
}
