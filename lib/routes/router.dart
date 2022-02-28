import 'package:auto_route/auto_route.dart';
import 'package:flutter_scene_recognizer/screens/homescreen/homescreen.dart';
import 'package:flutter_scene_recognizer/screens/onboarding_wrapper/onboarding_wrapper.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: OnboardingWrapper, initial: true),
    AutoRoute(page: Homescreen, path: 'homescreen'),
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
