// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:cloud_firestore/cloud_firestore.dart' as _i8;
import 'package:flutter/material.dart' as _i7;

import '../screens/firegallery/fire_gallery.dart' as _i4;
import '../screens/homescreen/homescreen.dart' as _i2;
import '../screens/onboarding_wrapper/onboarding_wrapper.dart' as _i1;
import '../screens/scene_recognizer/image_capture.dart' as _i3;
import '../widgets/gallery_details.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    OnboardingWrapper.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.OnboardingWrapper());
    },
    Homescreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.Homescreen());
    },
    ImageCapture.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.ImageCapture());
    },
    FireGallery.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.FireGallery());
    },
    GalleryDetails.name: (routeData) {
      final args = routeData.argsAs<GalleryDetailsArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.GalleryDetails(
              key: args.key,
              detailsImageUrl: args.detailsImageUrl,
              snapshot: args.snapshot));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(OnboardingWrapper.name, path: '/'),
        _i6.RouteConfig(Homescreen.name, path: 'homescreen'),
        _i6.RouteConfig(ImageCapture.name, path: 'image-capture'),
        _i6.RouteConfig(FireGallery.name, path: 'gallery'),
        _i6.RouteConfig(GalleryDetails.name, path: 'gallery-details')
      ];
}

/// generated route for
/// [_i1.OnboardingWrapper]
class OnboardingWrapper extends _i6.PageRouteInfo<void> {
  const OnboardingWrapper() : super(OnboardingWrapper.name, path: '/');

  static const String name = 'OnboardingWrapper';
}

/// generated route for
/// [_i2.Homescreen]
class Homescreen extends _i6.PageRouteInfo<void> {
  const Homescreen() : super(Homescreen.name, path: 'homescreen');

  static const String name = 'Homescreen';
}

/// generated route for
/// [_i3.ImageCapture]
class ImageCapture extends _i6.PageRouteInfo<void> {
  const ImageCapture() : super(ImageCapture.name, path: 'image-capture');

  static const String name = 'ImageCapture';
}

/// generated route for
/// [_i4.FireGallery]
class FireGallery extends _i6.PageRouteInfo<void> {
  const FireGallery() : super(FireGallery.name, path: 'gallery');

  static const String name = 'FireGallery';
}

/// generated route for
/// [_i5.GalleryDetails]
class GalleryDetails extends _i6.PageRouteInfo<GalleryDetailsArgs> {
  GalleryDetails(
      {_i7.Key? key,
      required String detailsImageUrl,
      required _i8.QueryDocumentSnapshot<Map<String, dynamic>> snapshot})
      : super(GalleryDetails.name,
            path: 'gallery-details',
            args: GalleryDetailsArgs(
                key: key,
                detailsImageUrl: detailsImageUrl,
                snapshot: snapshot));

  static const String name = 'GalleryDetails';
}

class GalleryDetailsArgs {
  const GalleryDetailsArgs(
      {this.key, required this.detailsImageUrl, required this.snapshot});

  final _i7.Key? key;

  final String detailsImageUrl;

  final _i8.QueryDocumentSnapshot<Map<String, dynamic>> snapshot;

  @override
  String toString() {
    return 'GalleryDetailsArgs{key: $key, detailsImageUrl: $detailsImageUrl, snapshot: $snapshot}';
  }
}
