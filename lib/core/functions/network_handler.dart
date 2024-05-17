import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHandler {
  static const storage = FlutterSecureStorage();

  static Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  static Future<http.Response> getRequest(String url,
      {Map<String, dynamic>? queryParams, bool includeToken = false}) async {
    if (!await _checkInternetConnection()) {
      throw Exception('No internet connection');
    }

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

    try {
      var response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  static Future<http.Response> postFormRequest(
      String url, Map<String, dynamic> data,
      {Map<String, dynamic>? queryParams,
      bool includeToken = false,
      List<File>? files}) async {
    if (!await _checkInternetConnection()) {
      throw Exception('No internet connection');
    }

    Map<String, String> headers = {};

    if (includeToken) {
      String? token = await getToken();
      headers["Authorization"] = "Bearer $token";
    }

    var uri = Uri.parse(url);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    var request = http.MultipartRequest('POST', uri)..headers.addAll(headers);

    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    if (files != null) {
      for (var file in files) {
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();

        var multipartFile = http.MultipartFile('file', stream, length,
            filename: basename(file.path));
        request.files.add(multipartFile);
      }
    }

    try {
      var streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      throw Exception('Failed to upload data');
    }
  }

  static Future<http.Response> postRequest(String url, var data,
      {Map<String, dynamic>? queryParams, bool includeToken = false}) async {
    if (!await _checkInternetConnection()) {
      throw Exception('No internet connection');
    }

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

    try {
      var response = await http.post(
        uri,
        body: json.encode(data),
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to send data');
    }
  }

  static Future<http.Response> postParamsRequest(String url,
      {Map<String, dynamic>? queryParams, bool includeToken = false}) async {
    if (!await _checkInternetConnection()) {
      throw Exception('No internet connection');
    }

    Map<String, String> headers = {};
    if (includeToken) {
      String? token = await getToken();
      headers["Authorization"] = "Bearer $token";
    }

    Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

    try {
      return await http.post(uri, headers: headers);
    } catch (e) {
      throw Exception('Failed to send data');
    }
  }

  static Future<void> storeToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  static Future<void> storeExpirationDate(String expiration) async {
    await storage.write(key: 'expiration', value: expiration);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  static Future<DateTime?> getExpirationDate() async {
    try {
      var store = await storage.read(key: 'expiration');
      if (store != null) {
        return DateTime.tryParse(store);
      }
    } catch (e) {
      print("Error fetching expiration date: $e");
    }
    return null;
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'expiration');
  }
}
