import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_scene_recognizer/screens/homescreen/homescreen.dart';
import 'package:flutterfire_ui/auth.dart';
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

    // If user is logged in show Home-, otherwise show SignIn/Registration-screen
    if (user == null) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SignInScreen(
          providerConfigs: [
            GoogleProviderConfiguration(
              clientId: dotenv.env['CLIENT_ID'] ?? 'CLIENT_ID not found',
            ),
            const EmailProviderConfiguration()
          ],
        ),
      );
    } else {
      return const Homescreen();
    }
  }
}
