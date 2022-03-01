import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_scene_recognizer/services/firestoreage_service.dart';
import 'package:provider/provider.dart';

import 'models/image_with_labels.dart';
import 'routes/router.gr.dart';
import 'services/auth_service.dart';

late FirebaseAnalytics analytics;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: dotenv.env['FB_API_KEY'] ?? 'API_URL not found',
        appId: dotenv.env['APP_ID'] ?? 'APP_ID not found',
        messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ??
            'MESSAGING_SENDER_ID not found',
        projectId: dotenv.env['FB_PROJECT_ID'] ?? 'FB_PROJECT_ID not found'),
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  analytics = FirebaseAnalytics.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: AuthService().user,
          initialData: null,
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate()),
      ),
    );
  }
}
