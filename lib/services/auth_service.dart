import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// This class contains all the methods that interact with the FirebaseAuth-backend

class AuthService {
  // private reference to the FirebaseAuth.instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sign-out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }
}
