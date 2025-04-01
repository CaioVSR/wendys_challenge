import 'package:wendys_challenge/core/base/base_injection.dart';

/// Injection class for the `Home` feature.
///
/// This class extends [BaseInjection] and is responsible for registering the
/// dependencies required by a specific feature. It registers the necessary
/// dependencies (such as cubits, repositories, or services) needed to manage
/// the feature's state and functionality.
class HomeInjections extends BaseInjection {
  /// Creates a new instance of the injection class.
  ///
  /// The constructor registers the necessary dependencies using the dependency
  /// injection container.
  HomeInjections() : super(scopeName: 'Home', registrations: []);
}
