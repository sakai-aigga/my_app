// Store flutter data locally
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthSessionStorage {
  AuthSessionStorage._();

  static const _isLoggedInKey = 'is_logged_in';
  static const _emailKey = 'user_email';
  static const _passwordKey = 'user_password';

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _isLoggedInKey);
    return value == 'true';
  }

  static Future<void> setLoggedIn(String email, String password) async {
    await _storage.write(key: _isLoggedInKey, value: 'true');
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _passwordKey, value: password);
  }

  static Future<Map<String, String?>> getCredentials() async {
    final email = await _storage.read(key: _emailKey);
    final password = await _storage.read(key: _passwordKey);
    return {'email': email, 'password': password};
  }

  static Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}
