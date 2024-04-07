import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  static final storage = const FlutterSecureStorage();

  static Future<http.Response> getRequest(String url,
      {bool includeToken = false}) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    if (includeToken) {
      headers["authorization"] = "Bearer ${await getToken('token')}";
    }

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> postRequest(String url, var data,
      {bool includeToken = false}) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (includeToken) {
      headers["authorization"] = "Bearer ${await getToken('token')}";
    }
    var response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: headers,
    );
    return response;
  }

  static Future<void> storeToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken(String token) async {
    return await storage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
