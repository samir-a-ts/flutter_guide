import 'package:dio/dio.dart';
import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_page_model.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_widget_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final testDioError = DioError(
    requestOptions: RequestOptions(path: ''),
  );

  const testPlaces = [
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

  late PlacesListRepositoryMock repository;

  PlacesListPageWidgetModel setUpWm() {
    repository = PlacesListRepositoryMock();

    return PlacesListPageWidgetModel(
      PlacesListPageModel(repository),
    );
  }

  testWidgetModel(
    'Successful first load adds places and evokes content (success) state.',
    setUpWm,
    (wm, tester, context) async {
      when(() => repository.getAllPlaces(0))
          .thenAnswer((invocation) async => testPlaces);

      await wm.model.loadPlacesList();

      expect(wm.placesListState.value!.data, isNotEmpty);

      expect(wm.placesListState.value!.hasError, false);

      expect(wm.arePlacesLoaded.value, true);

      expect(wm.arePlacesReloading.value, false);
    },
  );

  testWidgetModel(
    'Failed first load does not add places and evokes error state.',
    setUpWm,
    (wm, tester, context) async {
      when(
        () => repository.getAllPlaces(0),
      ).thenAnswer(
        (invocation) => Future.error(
          testDioError,
        ),
      );

      await wm.model.loadPlacesList();

      expect(wm.placesListState.value!.data, isEmpty);

      expect(wm.placesListState.value!.hasError, true);

      expect(wm.arePlacesLoaded.value, false);

      expect(wm.arePlacesReloading.value, false);
    },
  );

  testWidgetModel(
    'Data loading changes corresponding UI states.',
    setUpWm,
    (wm, tester, context) async {
      for (var i = 0; i < 2; i++) {
        when(
          () => repository.getAllPlaces(i),
        ).thenAnswer(
          (invocation) async {
            await Future<void>.delayed(const Duration(milliseconds: 500));

            return testPlaces;
          },
        );
      }

      final future1 = wm.model.loadPlacesList();

      expect(wm.placesListState.value!.isLoading, true);

      expect(wm.arePlacesLoaded.value, false);

      expect(wm.arePlacesReloading.value, false);

      await future1;

      expect(wm.placesListState.value!.isLoading, false);

      expect(wm.arePlacesLoaded.value, true);

      expect(wm.arePlacesReloading.value, false);

      final future2 = wm.model.loadPlacesList();

      expect(wm.arePlacesLoaded.value, true);

      expect(wm.arePlacesReloading.value, true);

      await future2;

      expect(wm.arePlacesLoaded.value, true);

      expect(wm.arePlacesReloading.value, false);
    },
  );

  testWidgetModel(
    'Sudden exception between reloadings changes corresponding UI states.',
    setUpWm,
    (wm, tester, context) async {
      when(() => repository.getAllPlaces(0))
          .thenAnswer((invocation) async => testPlaces);

      when(() => repository.getAllPlaces(1)).thenAnswer(
        (invocation) => Future.error(testDioError),
      );

      final future1 = wm.model.loadPlacesList();

      expect(wm.placesListState.value!.isLoading, true);

      expect(wm.arePlacesLoaded.value, false);

      expect(wm.arePlacesReloading.value, false);

      await future1;

      expect(wm.placesListState.value!.isLoading, false);

      expect(wm.arePlacesLoaded.value, true);

      expect(wm.arePlacesReloading.value, false);

      final future2 = wm.model.loadPlacesList();

      expect(wm.arePlacesLoaded.value, true);

      expect(wm.arePlacesReloading.value, true);

      await future2;

      expect(wm.placesListState.value!.hasError, true);

      expect(wm.arePlacesLoaded.value, true);

      expect(wm.arePlacesReloading.value, false);
    },
  );

  testWidgetModel(
    'Refresh changes corresponding UI states and resets places to loaded ones.',
    setUpWm,
    (wm, tester, context) async {
      for (var i = 0; i < 2; i++) {
        when(
          () => repository.getAllPlaces(i),
        ).thenAnswer((invocation) async => testPlaces);
      }

      for (var i = 0; i < 2; i++) {
        await wm.model.loadPlacesList();
      }

      expect(wm.placesListState.value!.data!.length, equals(20));

      await wm.refresh();

      expect(wm.placesListState.value!.data!.length, equals(10));
    },
  );
}

class PlacesListRepositoryMock extends Mock implements IPlacesListRepository {}
