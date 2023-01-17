import 'dart:io';

Future<void> main(List<String> args) async {
  final yandexKey = args[0];

  final file = File(
    '../android/app/src/main/kotlin/com/example/flutter_guide/MainActivity.kt',
  );

  final contents = await file.readAsString();

  await file.writeAsString(contents.replaceAll(r'$key$', yandexKey));
}
