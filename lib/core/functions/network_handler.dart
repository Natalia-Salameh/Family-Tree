import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  static const storage = FlutterSecureStorage();

  static Future<http.Response> getRequest(String url,
      {Map<String, dynamic>? queryParams, bool includeToken = false}) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    if (includeToken) {
      String? token = await getToken();
      headers["Authorization"] = "Bearer $token";
    }

    var uri = Uri.parse(url);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    var response = await http.get(
      uri,
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> postRequest(String url, var data,
      {Map<String, dynamic>? queryParams, bool includeToken = false}) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (includeToken) {
      String? token = await getToken();
      headers["Authorization"] = "Bearer $token";
    }
    var uri = Uri.parse(url);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
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

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
