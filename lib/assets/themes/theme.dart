import 'package:flutter/material.dart';

/// Additional colors in the
/// pallette of the design.
class AppTheme extends ThemeExtension<AppTheme> {
  /// Third color.
  final Color thirdColor;

  /// Yellow color.
  final Color yellowColor;

  /// Additional color.
  final Color additionalColor;

  /// Color of shadows.
  final Color shadowColor;

  /// Constructor for [AppTheme].
  const AppTheme({
    required this.shadowColor,
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
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
    );
  }

  @override
  AppTheme copyWith({
    Color? thirdColor,
    Color? yellowColor,
    Color? additionalColor,
    Color? shadowColor,
  }) {
    return AppTheme(
      thirdColor: thirdColor ?? this.thirdColor,
      yellowColor: yellowColor ?? this.yellowColor,
      additionalColor: additionalColor ?? this.additionalColor,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  /// To quickly access additional
  /// colors of pallette without writing
  /// it via [Theme]
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
  shadowColor: Color.fromRGBO(26, 26, 32, .16),
);

/// Light [ThemeData] of app.
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
  ),
  extensions: const [_appTheme],
);

/// Dark [ThemeData] of app.
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

/// To quickly access other colors
/// not presented in [ThemeData] directly,
/// but in the [ColorScheme]
abstract class ThemeHelper {
  /// Primary color from [ColorScheme].
  static Color mainColor(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;

  /// Secondary color from [ColorScheme].
  static Color secondaryColor(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  /// Text color of majority of widgets from [ColorScheme].
  static Color mainTextColor(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  /// Text theme from [Theme].
  static TextTheme textTheme(BuildContext context) =>
      Theme.of(context).textTheme;
}
