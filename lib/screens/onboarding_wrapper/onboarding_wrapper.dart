import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scene_recognizer/screens/homescreen/homescreen.dart';
import 'package:provider/provider.dart';

class OnboardingWrapper extends StatefulWidget {
  const OnboardingWrapper({Key? key}) : super(key: key);

  @override
  _OnboardingWrapperState createState() => _OnboardingWrapperState();
}

class _OnboardingWrapperState extends State<OnboardingWrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context, listen: true);
    // If user is logged in show Home-, otherwise show Authenticate-screen
    if (user == null) {
      return Container();
      //return FireLoginScreen();
    } else {
      // TODO: if (user.isEmailVerified){return HomeScreen();}
      // TODO:else{return PleaseVerifyYourEmailScreen()}

      return const Homescreen();

      /*  return ChangeNotifierProvider(
          create: (_) => StudentAuthInstance(), child: HomescreenWrapper()); */
    }
  }
}
