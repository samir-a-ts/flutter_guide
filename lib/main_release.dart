import 'package:flutter_guide/config/app_config.dart';
import 'package:flutter_guide/config/debug_options.dart';
import 'package:flutter_guide/config/environment/build_type.dart';
import 'package:flutter_guide/config/environment/environment.dart';
import 'package:flutter_guide/config/urls.dart';
import 'package:flutter_guide/runner.dart';

void main() {
  Environment.init(
    buildType: BuildType.release,
    config: AppConfig(
      url: Url.baseUrl,
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
