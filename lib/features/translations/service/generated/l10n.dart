// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppTranslations {
  AppTranslations();

  static AppTranslations? _current;

  static AppTranslations get current {
    assert(_current != null,
        'No instance of AppTranslations was loaded. Try to initialize the AppTranslations delegate before accessing AppTranslations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppTranslations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppTranslations();
      AppTranslations._current = instance;

      return instance;
    });
  }

  static AppTranslations of(BuildContext context) {
    final instance = AppTranslations.maybeOf(context);
    assert(instance != null,
        'No instance of AppTranslations present in the widget tree. Did you add AppTranslations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppTranslations? maybeOf(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  /// `Пропустить`
  String get skip {
    return Intl.message(
      'Пропустить',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `На старт`
  String get letsGo {
    return Intl.message(
      'На старт',
      name: 'letsGo',
      desc: '',
      args: [],
    );
  }

  /// `Добро пожаловать в Путеводитель`
  String get tutorialTitle1 {
    return Intl.message(
      'Добро пожаловать в Путеводитель',
      name: 'tutorialTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Ищи новые локации и сохраняй самые любимые.`
  String get tutorialSubtitle1 {
    return Intl.message(
      'Ищи новые локации и сохраняй самые любимые.',
      name: 'tutorialSubtitle1',
      desc: '',
      args: [],
    );
  }

  /// `Построй маршрут и отправляйся в путь`
  String get tutorialTitle2 {
    return Intl.message(
      'Построй маршрут и отправляйся в путь',
      name: 'tutorialTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Достигай цели максимально быстро и комфортно.`
  String get tutorialSubtitle2 {
    return Intl.message(
      'Достигай цели максимально быстро и комфортно.',
      name: 'tutorialSubtitle2',
      desc: '',
      args: [],
    );
  }

  /// `Добавляй места, которые нашёл сам`
  String get tutorialTitle3 {
    return Intl.message(
      'Добавляй места, которые нашёл сам',
      name: 'tutorialTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Делись самыми интересными и помоги нам стать лучше!`
  String get tutorialSubtitle3 {
    return Intl.message(
      'Делись самыми интересными и помоги нам стать лучше!',
      name: 'tutorialSubtitle3',
      desc: '',
      args: [],
    );
  }

  /// `Список интересных мест`
  String get placesListTitle {
    return Intl.message(
      'Список интересных мест',
      name: 'placesListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Поиск`
  String get search {
    return Intl.message(
      'Поиск',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Кафе`
  String get cafe {
    return Intl.message(
      'Кафе',
      name: 'cafe',
      desc: '',
      args: [],
    );
  }

  /// `Ресторан`
  String get restaurant {
    return Intl.message(
      'Ресторан',
      name: 'restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Музей`
  String get museum {
    return Intl.message(
      'Музей',
      name: 'museum',
      desc: '',
      args: [],
    );
  }

  /// `Парк`
  String get park {
    return Intl.message(
      'Парк',
      name: 'park',
      desc: '',
      args: [],
    );
  }

  /// `Отель`
  String get hotel {
    return Intl.message(
      'Отель',
      name: 'hotel',
      desc: '',
      args: [],
    );
  }

  /// `Особое место`
  String get other {
    return Intl.message(
      'Особое место',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка`
  String get error {
    return Intl.message(
      'Ошибка',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Новое место`
  String get newPlace {
    return Intl.message(
      'Новое место',
      name: 'newPlace',
      desc: '',
      args: [],
    );
  }

  /// `Вы искали`
  String get youSearched {
    return Intl.message(
      'Вы искали',
      name: 'youSearched',
      desc: '',
      args: [],
    );
  }

  /// `Очистить историю`
  String get clearHistory {
    return Intl.message(
      'Очистить историю',
      name: 'clearHistory',
      desc: '',
      args: [],
    );
  }

  /// `Упс, что-то пошло не так...`
  String get somethingWrong {
    return Intl.message(
      'Упс, что-то пошло не так...',
      name: 'somethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Ничего не найдено.`
  String get emptyTitle {
    return Intl.message(
      'Ничего не найдено.',
      name: 'emptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Попробуйте изменить параметры поиска`
  String get emptyMessage {
    return Intl.message(
      'Попробуйте изменить параметры поиска',
      name: 'emptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Категории`
  String get categories {
    return Intl.message(
      'Категории',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Очистить`
  String get clear {
    return Intl.message(
      'Очистить',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Расстояние`
  String get distance {
    return Intl.message(
      'Расстояние',
      name: 'distance',
      desc: '',
      args: [],
    );
  }

  /// `до {to} км`
  String fromToDistance(Object to) {
    return Intl.message(
      'до $to км',
      name: 'fromToDistance',
      desc: '',
      args: [to],
    );
  }

  /// `Загрузка...`
  String get loading {
    return Intl.message(
      'Загрузка...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Показать`
  String get showFiltered {
    return Intl.message(
      'Показать',
      name: 'showFiltered',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel {
    return Intl.message(
      'Отмена',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Категория`
  String get category {
    return Intl.message(
      'Категория',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Создать`
  String get create {
    return Intl.message(
      'Создать',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Описание`
  String get description {
    return Intl.message(
      'Описание',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Указать на карте`
  String get searchOnMap {
    return Intl.message(
      'Указать на карте',
      name: 'searchOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Название`
  String get title {
    return Intl.message(
      'Название',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Широта`
  String get latitude {
    return Intl.message(
      'Широта',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `Долгота`
  String get longitude {
    return Intl.message(
      'Долгота',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `Не выбрано`
  String get notChosen {
    return Intl.message(
      'Не выбрано',
      name: 'notChosen',
      desc: '',
      args: [],
    );
  }

  /// `Камера`
  String get camera {
    return Intl.message(
      'Камера',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Галерея`
  String get gallery {
    return Intl.message(
      'Галерея',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message(
      'Сохранить',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Успех!`
  String get success {
    return Intl.message(
      'Успех!',
      name: 'success',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppTranslations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppTranslations> load(Locale locale) => AppTranslations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
