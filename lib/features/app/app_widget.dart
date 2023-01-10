import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/strings/constants.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/di_scope/di_scope.dart';
import 'package:flutter_guide/config/app_config.dart';
import 'package:flutter_guide/config/environment/environment.dart';
import 'package:flutter_guide/features/app/di/app_scope.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// You need to customize for your project.
const _localizations = [Locale('ru')];

const _localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  AppTranslations.delegate,
];

/// App widget.
class AppWidget extends StatefulWidget {
  /// Create an instance App.
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final IAppScope _scope = AppScope();

  @override
  Widget build(BuildContext context) {
    final debugConfig = Environment<AppConfig>.instance().config.debugOptions;

    return DiScope<IAppScope>(
      factory: () => _scope,
      child: ScreenUtilInit(
        designSize: const Size(360, 760),
        builder: (context, child) => child!,
        child: MaterialApp.router(
          title: kAppName,

          /// Localization.
          locale: _localizations.first,
          localizationsDelegates: _localizationsDelegates,
          supportedLocales: _localizations,

          /// Debug configuration.
          showPerformanceOverlay: debugConfig.showPerformanceOverlay,
          debugShowMaterialGrid: debugConfig.debugShowMaterialGrid,
          checkerboardRasterCacheImages:
              debugConfig.checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: debugConfig.checkerboardOffscreenLayers,
          showSemanticsDebugger: debugConfig.showSemanticsDebugger,
          debugShowCheckedModeBanner: debugConfig.debugShowCheckedModeBanner,

          /// This is for navigation.
          routeInformationParser: _scope.router.defaultRouteParser(),
          routerDelegate: _scope.router.delegate(),
          routeInformationProvider: _scope.router.routeInfoProvider(),

          /// Theming
          theme: lightTheme,
          darkTheme: darkTheme,
        ),
      ),
    );
  }
}
