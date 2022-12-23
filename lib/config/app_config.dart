import 'package:flutter_guide/config/debug_options.dart';

/// Application configuration.
class AppConfig {
  /// Server url.
  final String url;

  /// Additional application settings in debug mode.
  final DebugOptions debugOptions;

  /// Create an instance [AppConfig].
  AppConfig({
    required this.url,
    required this.debugOptions,
  });

  /// Create an instance [AppConfig] with modified parameters.
  AppConfig copyWith({
    String? url,
    DebugOptions? debugOptions,
  }) =>
      AppConfig(
        url: url ?? this.url,
        debugOptions: debugOptions ?? this.debugOptions,
      );
}
