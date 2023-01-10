import 'package:elementary/elementary.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_model.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_widget.dart';

/// Widget model for [PlacesFilterPage].
abstract class IPlacesFilterWidgetModel extends IWidgetModel {}

/// Widget model implementation for [PlacesFilterPage].
class PlacesFilterWidgetModel
    extends WidgetModel<PlacesFilterPage, PlacesFilterModel>
    implements IPlacesFilterWidgetModel {
  /// Constructor for [PlacesFilterWidgetModel].
  PlacesFilterWidgetModel(PlacesFilterModel model) : super(model);
}
