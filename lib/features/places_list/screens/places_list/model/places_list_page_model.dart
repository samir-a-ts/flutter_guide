import 'package:elementary/elementary.dart';
import 'package:flutter_guide/features/places_list/domain/entity/place.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';

/// Model for `PlacesListPage`.
class PlacesListPageModel extends ElementaryModel {
  final IPlacesListRepository _repository;

  /// Initialization.
  PlacesListPageModel(this._repository);

  /// Loads all places.
  ///
  /// See [IPlacesListRepository].
  Future<List<Place>> loadPlaces(
    int page, [
    int recordsPerPage = 10,
  ]) =>
      _repository.getAllPlaces(page, recordsPerPage);
}
