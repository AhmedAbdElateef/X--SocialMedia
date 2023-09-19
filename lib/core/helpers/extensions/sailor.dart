import 'package:flutter/material.dart';
//-------------------------------------

/// global variable to access sailor which is a navigation service
/// that controls routes easily and without the need of passing contexts.
// ignore: non_constant_identifier_names
final Sailor = _SailorImpl();

// prevents sailor implementation to be accessed from outside this file.
class _SailorImpl {
  /// global key which controls navigation state.
  final _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}

// ignore: library_private_types_in_public_api
extension NavigationMethods on _SailorImpl {
  /// use [to] instead of [Navigator.push].
  Future<dynamic> to(Widget newScreen) {
    return _navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_) => newScreen),
    );
  }

  /// use [toNamed] instead of [Navigator.pushNamed].
  Future<dynamic> toNamed<T>(String newRoute, {T? routeArgs}) {
    return _navigatorKey.currentState!.pushNamed(
      newRoute,
      arguments: routeArgs,
    );
  }

  /// use [startOverFromRoute] instead of [Navigator.pushNamedAndRemoveUntil].
  Future<dynamic> startOverFromRoute(String startRoute) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      startRoute,
      (_) => false,
    );
  }

  /// use [back] instead of [Navigator.pop].
  void back([dynamic result]) {
    _navigatorKey.currentState!.pop(result);
  }
}
