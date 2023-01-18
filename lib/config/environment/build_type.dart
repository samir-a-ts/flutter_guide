/// App build type.
/// When building from the CLI, they are governed by the
/// assembly from the corresponding file main-\***.dart
/// ```
///   flutter build *** -t lib/main-***.dart
/// ```
///
enum BuildType {
  /// Debug build type.
  debug,

  /// Production build type.
  production,
}
