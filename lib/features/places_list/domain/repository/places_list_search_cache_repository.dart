import 'package:flutter_guide/features/places_list/domain/entity/search_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Interface for [PlacesSearchCacheRepository]
abstract class IPlacesSearchCacheRepository {
  /// Loads cached [SearchHistory] from
  /// [SharedPreferences] local storage.
  SearchHistory getSearchHistory();

  /// Updates value in [SharedPreferences]
  /// cache.
  Future<void> cacheSearchHistory(SearchHistory searchHistory);
}

/// Search history cache manager. Update + read.
class PlacesSearchCacheRepository extends IPlacesSearchCacheRepository {
  final SharedPreferences _sharedPreferences;

  final _searchHistoryKey = 'SEARCH_HISTORY_CACHE';

  /// Constructor for [PlacesSearchCacheRepository]
  PlacesSearchCacheRepository(this._sharedPreferences);

  @override
  Future<void> cacheSearchHistory(SearchHistory searchHistory) =>
      _sharedPreferences.setStringList(
        _searchHistoryKey,
        searchHistory.toList(),
      );

  @override
  SearchHistory getSearchHistory() => SearchHistory(
        _sharedPreferences.getStringList(
          _searchHistoryKey,
        ),
      );
}
