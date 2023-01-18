import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/common/widgets/place_card.dart';
import 'package:flutter_guide/features/map/di/map_scope_widget.dart';
import 'package:flutter_guide/features/map/screens/map_wm.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Widget that wraps [MapWidget]
/// and provides it with required
/// dependencies.
class MapPage extends StatelessWidget {
  /// Constructor for [MapPage]
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MapScopeWidget(
      child: MapWidget(),
    );
  }
}

/// Elementary widget for map module
class MapWidget extends ElementaryWidget<IMapWidgetModel> {
  /// Constructor for [MapWidget]
  const MapWidget({
    Key? key,
  }) : super(defaultMapWidgetModelFactory, key: key);

  @override
  Widget build(IMapWidgetModel wm) {
    return Scaffold(
      appBar: MainAppBar(
        title: wm.mapText,
      ),
      body: Stack(
        children: [
          StateNotifierBuilder(
            listenableState: wm.mapObjectsState,
            builder: (context, mapObjects) {
              return YandexMap(
                logoAlignment: const MapAlignment(
                  horizontal: HorizontalAlignment.left,
                  vertical: VerticalAlignment.top,
                ),
                mapType: MapType.hybrid,
                onMapCreated: wm.onMapCreated,
                mapObjects: mapObjects!,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _MapFloatingButton(
                        icon: Icons.refresh,
                        onTap: wm.onRefreshButtonTap,
                      ),
                      _MapFloatingButton(
                        icon: Icons.maps_ugc,
                        onTap: wm.onRefreshPositionTap,
                      ),
                    ],
                  ),
                  StateNotifierBuilder(
                    listenableState: wm.selectedPlaceState,
                    builder: (context, place) {
                      if (place == null) return const SizedBox();

                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: PlaceCard(
                          place: place,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapFloatingButton extends StatelessWidget {
  final IconData icon;

  final VoidCallback onTap;

  const _MapFloatingButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              color: AppTheme.of(context).shadowColor,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: ThemeHelper.mainTextColor(context),
          size: 26,
        ),
      ),
    );
  }
}
