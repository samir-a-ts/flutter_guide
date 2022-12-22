import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color thirdColor;

  final Color yellowColor;

  final Color additionalColor;

  const AppTheme({
    required this.additionalColor,
    required this.thirdColor,
    required this.yellowColor,
  });

  @override
  ThemeExtension<AppTheme> lerp(
    ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) {
      return this;
    }

    return AppTheme(
      additionalColor: Color.lerp(additionalColor, other.additionalColor, t)!,
      thirdColor: Color.lerp(thirdColor, other.thirdColor, t)!,
      yellowColor: Color.lerp(yellowColor, other.yellowColor, t)!,
    );
  }

  @override
  AppTheme copyWith({
    Color? thirdColor,
    Color? yellowColor,
    Color? additionalColor,
  }) {
    return AppTheme(
      thirdColor: thirdColor ?? this.thirdColor,
      yellowColor: yellowColor ?? this.yellowColor,
      additionalColor: additionalColor ?? this.additionalColor,
    );
  }

  static AppTheme of(BuildContext context) =>
      Theme.of(context).extension<AppTheme>()!;
}

const _textTheme = TextTheme(
  titleLarge: TextStyle(fontSize: 32),
  titleMedium: TextStyle(fontSize: 24),
  titleSmall: TextStyle(fontSize: 18),
  bodyMedium: TextStyle(fontSize: 16),
  labelMedium: TextStyle(fontSize: 14),
  labelSmall: TextStyle(fontSize: 12),
);

const _appTheme = AppTheme(
  additionalColor: Color(0xFFF5F5F5),
  thirdColor: Color(0xFF7C7E92),
  yellowColor: Color(0xFFFCDD3D),
);

final lightTheme = ThemeData(
  textTheme: _textTheme,
  backgroundColor: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  primaryColor: const Color(0xFF4CAF50),
  errorColor: const Color(0xFFEF4343),
  disabledColor: const Color.fromRGBO(124, 126, 146, 0.56),
  colorScheme: const ColorScheme.dark(
    primaryContainer: Color(0xFF252849),
    secondaryContainer: Color(0xFF3B3E5B),
    onPrimary: Color(0xFF000000),
  ),
  extensions: const [_appTheme],
);

final darkTheme = ThemeData(
  textTheme: _textTheme.apply(bodyColor: Colors.white),
  backgroundColor: const Color(0xFF21222C),
  scaffoldBackgroundColor: const Color(0xFF21222C),
  primaryColor: const Color(0xFF6ADA6F),
  errorColor: const Color(0xFFEF4343),
  disabledColor: const Color.fromRGBO(124, 126, 146, 0.56),
  colorScheme: const ColorScheme.dark(
    primaryContainer: Color(0xFF21222C),
    secondaryContainer: Color(0xFF3B3E5B),
    onPrimary: Color(0xFFFFFFFF),
  ),
  extensions: [
    _appTheme.copyWith(
      additionalColor: const Color(0xFF1A1A20),
      yellowColor: const Color(0xFFFCDD3D),
    ),
  ],
);

abstract class ThemeHelper {
  static Color mainColor(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;

  static Color secondaryColor(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;
}
