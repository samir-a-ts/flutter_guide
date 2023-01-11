import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_search_cache_repository.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_model.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_wm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../places/places_list_model_test.dart';

void main() {
  final repository = PlacesListRepositoryMock();
  final cache = PlacesSearchCacheRepositoryMock();

  const testPlaces = <Place>[
    Place(
      id: 0,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 1,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 2,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 3,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 4,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 5,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 6,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 7,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 8,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
    Place(
      id: 9,
      latitude: 35.234,
      longitude: 12.23,
      placeType: PlaceType.cafe,
      name: "Shrek's cafe",
      description: 'We are going to Britain mate.',
      images: ['some url lol'],
    ),
  ];

  PlacesSearchWidgetModel setUpWm() => PlacesSearchWidgetModel(
        PlacesSearchModel(
          repository,
          cache,
        ),
      );

  testWidgetModel(
    'Successful setup and auto-load of history',
    setUpWm,
    (wm, tester, context) {
      const cacheList = ['test', 'tes'];

      when<List<String>>(cache.getSearchHistory).thenAnswer(
        (invocation) => cacheList,
      );

      wm.initWidgetModel();

      expect(wm.searchHistory.value, isNotEmpty);

      expect(wm.foundPlacesState.value!.data, isEmpty);
    },
  );

  testWidgetModel(
    'Successful cache interactions',
    setUpWm,
    (wm, tester, context) {
      const cacheList = ['test', 'tes'];

      when<List<String>>(cache.getSearchHistory).thenAnswer(
        (invocation) => cacheList,
      );

      wm.initWidgetModel();

      expect(wm.searchHistory.value, isNotEmpty);

      expect(wm.foundPlacesState.value!.data, isEmpty);

      wm.model.saveSearch('something');

      wm.deleteHistoryAt(1);

      expect(
        wm.searchHistory.value,
        equals(['something', 'tes']),
      );

      wm.clearHistory();

      expect(
        wm.searchHistory.value,
        isEmpty,
      );
    },
  );

  testWidgetModel(
    'Successful search interactions',
    setUpWm,
    (wm, tester, context) async {
      when<Future<List<Place>>>(
        () => repository.getFilteredPlaces(name: 'Shrek'),
      ).thenAnswer(
        (invocation) {
          return Future.value(testPlaces);
        },
      );

      wm.initWidgetModel();

      wm.model.onSearch('Shrek');

      expect(wm.foundPlacesState.value!.isLoading, equals(true));

      await Future<dynamic>.delayed(
        const Duration(seconds: 1, milliseconds: 200),
      );

      expect(wm.foundPlacesState.value!.isLoading, equals(false));

      expect(wm.foundPlacesState.value!.data, isNotEmpty);

      expect(wm.foundPlacesState.value!.hasError, equals(false));
    },
  );

  testWidgetModel(
    'Successful error handle',
    setUpWm,
    (wm, tester, context) async {
      when<Future<List<Place>>>(
        () => repository.getFilteredPlaces(name: 'Shre'),
      ).thenThrow(Exception());

      wm.initWidgetModel();

      wm.model.onSearch('Shre');

      await Future<dynamic>.delayed(
        const Duration(seconds: 1, milliseconds: 200),
      );

      expect(wm.foundPlacesState.value!.hasError, equals(true));
    },
  );

  testWidgetModel(
    'Successful ignorance of the same as previous/empty search query',
    setUpWm,
    (wm, tester, context) async {
      when<Future<List<Place>>>(
        repository.getFilteredPlaces,
      ).thenAnswer((_) => Future.value(testPlaces));

      wm.initWidgetModel();

      wm.model.onSearch('');

      await Future<dynamic>.delayed(
        const Duration(seconds: 1, milliseconds: 200),
      );

      expect(wm.foundPlacesState.value!.data, isEmpty);

      wm.model.onSearch('Shrek');

      await Future<dynamic>.delayed(
        const Duration(seconds: 1, milliseconds: 200),
      );

      expect(wm.foundPlacesState.value!.data, isNotEmpty);

      wm.model.onSearch('Shrek');

      expect(wm.foundPlacesState.value!.data, equals(testPlaces));
    },
  );
}

class PlacesSearchCacheRepositoryMock extends Mock
    implements IPlacesSearchCacheRepository {}
