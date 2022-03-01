import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scene_recognizer/screens/firegallery/fire_gallery.dart';
import 'package:flutter_scene_recognizer/screens/flutter_fire_gallery/flutter_fire_gallery.dart';
import 'package:flutter_scene_recognizer/screens/scene_recognizer/image_capture.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
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
                  : const Text('logout'))
        ],
        title: const Text('Scene Recognizer'),
      ),
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        //onPageChanged: (index) => _onItemTapped(index),
        children: [
          Container(color: Colors.red),
          const ImageCapture(),
          FlutterFireGallery(),
          //const FireGallery()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
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
