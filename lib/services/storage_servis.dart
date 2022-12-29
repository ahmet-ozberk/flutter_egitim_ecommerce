import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static void setToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static void deleteToken() async {
    await storage.delete(key: "token");
  }
}
