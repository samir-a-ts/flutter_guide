import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color mainColor;

  final Color secondaryColor;

  final Color thirdColor;

  final Color inactiveColor;

  final Color greenColor;

  final Color yellowColor;

  final Color errorOrDeleteColor;

  final Color additionalColor;

  const AppTheme({
    required this.greenColor,
    required this.additionalColor,
    required this.mainColor,
    required this.secondaryColor,
    required this.thirdColor,
    required this.inactiveColor,
    required this.yellowColor,
    required this.errorOrDeleteColor,
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
      mainColor: Color.lerp(mainColor, other.mainColor, t)!,
      greenColor: Color.lerp(greenColor, other.greenColor, t)!,
      additionalColor: Color.lerp(additionalColor, other.additionalColor, t)!,
      secondaryColor: Color.lerp(additionalColor, other.additionalColor, t)!,
      thirdColor: Color.lerp(thirdColor, other.thirdColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      errorOrDeleteColor:
          Color.lerp(errorOrDeleteColor, other.errorOrDeleteColor, t)!,
      yellowColor: Color.lerp(yellowColor, other.yellowColor, t)!,
    );
  }

  @override
  AppTheme copyWith({
    Color? mainColor,
    Color? secondaryColor,
    Color? thirdColor,
    Color? inactiveColor,
    Color? greenColor,
    Color? yellowColor,
    Color? errorOrDeleteColor,
    Color? additionalColor,
  }) {
    return AppTheme(
      mainColor: mainColor ?? this.mainColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      thirdColor: thirdColor ?? this.thirdColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      greenColor: greenColor ?? this.greenColor,
      yellowColor: yellowColor ?? this.yellowColor,
      errorOrDeleteColor: errorOrDeleteColor ?? this.errorOrDeleteColor,
      additionalColor: additionalColor ?? this.additionalColor,
    );
  }

  static AppTheme of(BuildContext context) =>
      Theme.of(context).extension<AppTheme>()!;
}

const _textTheme = TextTheme(
  titleLarge: TextStyle(fontSize: 32, height: 36),
  titleMedium: TextStyle(fontSize: 24, height: 29),
  titleSmall: TextStyle(fontSize: 18, height: 24),
  bodyMedium: TextStyle(fontSize: 16, height: 20),
  labelMedium: TextStyle(fontSize: 14, height: 18),
  labelSmall: TextStyle(fontSize: 12, height: 16),
);

const _appTheme = AppTheme(
  greenColor: Color(0xFF4CAF50),
  additionalColor: Color(0xFFF5F5F5),
  mainColor: Color(0xFF252849),
  secondaryColor: Color(0xFF3B3E5B),
  thirdColor: Color(0xFF7C7E92),
  inactiveColor: Color.fromRGBO(124, 126, 146, 0.56),
  yellowColor: Color(0xFFFCDD3D),
  errorOrDeleteColor: Color(0xFFEF4343),
);

final lightTheme = ThemeData(
  textTheme: _textTheme,
  backgroundColor: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  extensions: const [_appTheme],
);

final darkTheme = ThemeData(
  textTheme: _textTheme.apply(bodyColor: Colors.white),
  backgroundColor: const Color(0xFF21222C),
  scaffoldBackgroundColor: const Color(0xFF21222C),
  extensions: [
    _appTheme.copyWith(
      greenColor: const Color(0xFF6ADA6F),
      additionalColor: const Color(0xFF1A1A20),
      mainColor: const Color(0xFF21222C),
      yellowColor: const Color(0xFFFCDD3D),
      errorOrDeleteColor: const Color(0xFFEF4343),
    ),
  ],
);
