import 'package:shared_preferences/shared_preferences.dart';

/// Interface for [PlacesSearchCacheRepository]
abstract class IPlacesSearchCacheRepository {
  /// Loads cached search history from
  /// [SharedPreferences] local storage.
  List<String> getSearchHistory();

  /// Updates value in [SharedPreferences]
  /// cache.
  Future<void> cacheSearchHistory(List<String> searchHistory);
}

/// Search history cache manager. Update + read.
class PlacesSearchCacheRepository extends IPlacesSearchCacheRepository {
  final SharedPreferences _sharedPreferences;

  final _searchHistoryKey = 'SEARCH_HISTORY_CACHE';

  /// Constructor for [PlacesSearchCacheRepository]
  PlacesSearchCacheRepository(this._sharedPreferences);

  @override
  Future<void> cacheSearchHistory(List<String> searchHistory) =>
      _sharedPreferences.setStringList(
        _searchHistoryKey,
        searchHistory,
      );

  @override
  List<String> getSearchHistory() =>
      _sharedPreferences.getStringList(
        _searchHistoryKey,
      ) ??
      [];
}
