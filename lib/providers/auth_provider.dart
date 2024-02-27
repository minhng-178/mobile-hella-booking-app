import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<void> checkTokens() async {
    String? refreshToken = await storage.read(key: 'refreshToken');
    _isLoggedIn = refreshToken != null;
  }

  Future<void> signOut() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    _isLoggedIn = false;
    notifyListeners();
  }
}
