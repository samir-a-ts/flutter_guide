import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/settings/screens/settings/widget/settings_page.dart';

/// Settings route.
const settingsRoutes = AutoRoute<dynamic>(
  path: AppRoutes.settings,
  page: SettingsPage,
);
