// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../screens/homescreen/homescreen.dart' as _i2;
import '../screens/onboarding_wrapper/onboarding_wrapper.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    OnboardingWrapper.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.OnboardingWrapper());
    },
    Homescreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.Homescreen());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(OnboardingWrapper.name, path: '/'),
        _i3.RouteConfig(Homescreen.name, path: 'homescreen')
      ];
}

/// generated route for
/// [_i1.OnboardingWrapper]
class OnboardingWrapper extends _i3.PageRouteInfo<void> {
  const OnboardingWrapper() : super(OnboardingWrapper.name, path: '/');

  static const String name = 'OnboardingWrapper';
}

/// generated route for
/// [_i2.Homescreen]
class Homescreen extends _i3.PageRouteInfo<void> {
  const Homescreen() : super(Homescreen.name, path: 'homescreen');

  static const String name = 'Homescreen';
}
