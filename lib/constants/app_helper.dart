import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_strings.dart';

class AppHelper {
  AppHelper._();

  static const _secureStorage = FlutterSecureStorage();
  static Future<String> getToken() async {
    String token = await _secureStorage.read(key: AppString.accessToken) ?? "";

    return token;
  }
}
