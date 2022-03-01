import 'package:auto_route/auto_route.dart';
import 'package:flutter_scene_recognizer/screens/firegallery/fire_gallery.dart';
import 'package:flutter_scene_recognizer/screens/homescreen/homescreen.dart';
import 'package:flutter_scene_recognizer/screens/onboarding_wrapper/onboarding_wrapper.dart';
import 'package:flutter_scene_recognizer/screens/scene_recognizer/image_capture.dart';
import 'package:flutter_scene_recognizer/widgets/gallery_details.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: OnboardingWrapper, initial: true),
    AutoRoute(page: Homescreen, path: 'homescreen'),
    AutoRoute(page: ImageCapture, path: 'image-capture'),
    AutoRoute(page: FireGallery, path: 'gallery'),
    AutoRoute(page: GalleryDetails, path: 'gallery-details'),
    /* AutoRoute(
        page: HomeScreen,
        path: '/homescreen',
        children: [AutoRoute(page: LessonDetailsPopup, path: 'lesson-popup')]), */
  ],
)
class $AppRouter {}
// run this command if something was changed with the routes 
// flutter pub run build_runner build --delete-conflicting-outputs

// for json_serializer flutter pub run build_runner build



//Splash screen
// flutter pub run flutter_native_splash:create
