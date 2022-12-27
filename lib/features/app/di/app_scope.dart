import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_guide/config/app_config.dart';
import 'package:flutter_guide/config/environment/environment.dart';
import 'package:flutter_guide/features/navigation/service/app_router.gr.dart';
import 'package:flutter_guide/util/default_error_handler.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final AppRouter _router;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  AppRouter get router => _router;

  /// Create an instance [AppScope].
  AppScope() {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[];

    _dio = _initDio(additionalInterceptors);
    _errorHandler = DefaultErrorHandler();
    _router = AppRouter();
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment<AppConfig>.instance().config.url
      ..connectTimeout = timeout.inMilliseconds
      ..receiveTimeout = timeout.inMilliseconds
      ..sendTimeout = timeout.inMilliseconds;

    dio.interceptors.addAll(additionalInterceptors);

    if (Environment<AppConfig>.instance().isDebug) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Class that coordinates navigation for the whole app.
  AppRouter get router;
}