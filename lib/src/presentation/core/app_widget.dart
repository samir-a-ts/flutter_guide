import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/constants/theme.dart';
import 'package:flutter_guide/src/core/router/app_router.gr.dart';
import 'package:flutter_guide/src/core/translations/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) => child!,
      child: MaterialApp.router(
        title: "Путеводитель",
        theme: lightTheme,
        darkTheme: darkTheme,
        routerDelegate: _appRouter.delegate(),
        routeInformationProvider: _appRouter.routeInfoProvider(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        localizationsDelegates: const [
          AppTranslations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppTranslations.delegate.supportedLocales,
        locale: const Locale("ru"),
      ),
    );
  }
}
