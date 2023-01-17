import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/place_card.dart';
import 'package:flutter_guide/features/map/di/map_scope_widget.dart';
import 'package:flutter_guide/features/map/screens/map_wm.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
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
            builder: (context, snapshot) {
              return YandexMap(
                onMapCreated: wm.onMapCreated,
                mapObjects: [],
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
                        onTap: wm.onRefreshButtonTap,
                      ),
                    ],
                  ),
                  StateNotifierBuilder(
                    listenableState: wm.selectedPlaceState,
                    builder: (context, place) {
                      if (place == null) return const SizedBox();

                      return PlaceCard(
                        place: place,
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
