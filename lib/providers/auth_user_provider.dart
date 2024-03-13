import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthUserProvider with ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  bool _isLoggedIn = false;
  User? _user;

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> checkTokens() async {
    String? refreshToken = await storage.read(key: 'refreshToken');
    _isLoggedIn = refreshToken != null;
  }

  Future<void> signOut() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    await storage.delete(key: 'userId');
    await storage.delete(key: 'userRole');
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    _isLoggedIn = false;
    _user = null;
    notifyListeners();
  }
}
