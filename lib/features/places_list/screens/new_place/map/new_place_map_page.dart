import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/domain/entities/static_points.dart';

/// New place -> map page.
class NewPlaceMapPage extends StatelessWidget {
  /// Constructor for [NewPlaceMapPage].
  const NewPlaceMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AutoRouter.of(context).popForced(
          PointHelper.moscow(),
        );

        return false;
      },
      child: Scaffold(
        body: Center(
          child: Text(
            'Map',
            style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                  color: ThemeHelper.mainTextColor(context),
                ),
          ),
        ),
      ),
    );
  }
}
