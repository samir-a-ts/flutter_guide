import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/constants/contants.dart';
import 'package:flutter_guide/src/core/constants/theme.dart';
import 'package:flutter_guide/src/core/router/app_router.gr.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerDelegate: _appRouter.delegate(),
      routeInformationProvider: _appRouter.routeInfoProvider(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
