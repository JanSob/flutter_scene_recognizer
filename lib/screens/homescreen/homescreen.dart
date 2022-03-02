import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scene_recognizer/screens/flutter_fire_gallery/flutter_fire_gallery.dart';
import 'package:flutter_scene_recognizer/screens/scene_recognizer/image_capture.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final AuthService _authService = AuthService();
  final PageController _controller =
      PageController(initialPage: 0, keepPage: false);
  bool isLoggingOut = false;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const createDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        title: const Text('Scene Recognizer'),
      ),
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: const [
          ImageCapture(),
          FlutterFireGallery(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
            label: 'Image Capture',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Cloud Gallery',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate);
    });
  }
}

class createDrawer extends StatefulWidget {
  const createDrawer({Key? key}) : super(key: key);

  @override
  State<createDrawer> createState() => _createDrawerState();
}

class _createDrawerState extends State<createDrawer> {
  bool isLoggingOut = false;
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User?>(context, listen: true)!;
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
                child: Text(
              "Email: " + (user.email ?? 'Anonymous user'),
              style: const TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.3,
            )),
          ),
          const SizedBox(height: 40),
          ListTile(
            title: Text("AcountID on Firebase: " + user.uid),
          ),
          ListTile(
            title: Text("Acount created: " +
                user.metadata.creationTime!.toIso8601String()),
          ),
          ListTile(
            title: Text("Last login: " +
                user.metadata.lastSignInTime!.toIso8601String()),
          ),
          ListTile(
              title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextButton.icon(
                onPressed: () async {
                  if (isLoggingOut) return;
                  setState(() {
                    isLoggingOut = true;
                  });
                  try {
                    await _authService.signOut();
                    setState(() {
                      isLoggingOut = false;
                    });
                  } catch (e) {
                    if (kDebugMode) {
                      print("logged out");
                    }
                  }
                },
                icon: isLoggingOut
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(Icons.logout),
                label: isLoggingOut
                    ? const Text('logging out..')
                    : const Text('logout')),
          )),
        ],
      ),
    );
  }
}
