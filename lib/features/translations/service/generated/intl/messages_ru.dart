// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(to) => "до ${to} км";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cafe": MessageLookupByLibrary.simpleMessage("Кафе"),
        "categories": MessageLookupByLibrary.simpleMessage("Категории"),
        "clear": MessageLookupByLibrary.simpleMessage("Очистить"),
        "clearHistory":
            MessageLookupByLibrary.simpleMessage("Очистить историю"),
        "distance": MessageLookupByLibrary.simpleMessage("Расстояние"),
        "emptyMessage": MessageLookupByLibrary.simpleMessage(
            "Попробуйте изменить параметры поиска"),
        "emptyTitle":
            MessageLookupByLibrary.simpleMessage("Ничего не найдено."),
        "error": MessageLookupByLibrary.simpleMessage("Ошибка"),
        "fromToDistance": m0,
        "hotel": MessageLookupByLibrary.simpleMessage("Отель"),
        "letsGo": MessageLookupByLibrary.simpleMessage("На старт"),
        "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
        "museum": MessageLookupByLibrary.simpleMessage("Музей"),
        "newPlace": MessageLookupByLibrary.simpleMessage("Новое место"),
        "other": MessageLookupByLibrary.simpleMessage("Особое место"),
        "park": MessageLookupByLibrary.simpleMessage("Парк"),
        "placesListTitle":
            MessageLookupByLibrary.simpleMessage("Список интересных мест"),
        "restaurant": MessageLookupByLibrary.simpleMessage("Ресторан"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "showFiltered": MessageLookupByLibrary.simpleMessage("Показать"),
        "skip": MessageLookupByLibrary.simpleMessage("Пропустить"),
        "somethingWrong":
            MessageLookupByLibrary.simpleMessage("Упс, что-то пошло не так..."),
        "tutorialSubtitle1": MessageLookupByLibrary.simpleMessage(
            "Ищи новые локации и сохраняй самые любимые."),
        "tutorialSubtitle2": MessageLookupByLibrary.simpleMessage(
            "Достигай цели максимально быстро и комфортно."),
        "tutorialSubtitle3": MessageLookupByLibrary.simpleMessage(
            "Делись самыми интересными и помоги нам стать лучше!"),
        "tutorialTitle1": MessageLookupByLibrary.simpleMessage(
            "Добро пожаловать в Путеводитель"),
        "tutorialTitle2": MessageLookupByLibrary.simpleMessage(
            "Построй маршрут и отправляйся в путь"),
        "tutorialTitle3": MessageLookupByLibrary.simpleMessage(
            "Добавляй места, которые нашёл сам"),
        "youSearched": MessageLookupByLibrary.simpleMessage("Вы искали")
      };
}
