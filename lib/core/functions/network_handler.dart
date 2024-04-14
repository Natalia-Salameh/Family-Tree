import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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

  static Future<http.Response> postFormRequest(
      String url, Map<String, dynamic> data,
      {Map<String, dynamic>? queryParams,
      bool includeToken = false,
      List<File>? files}) async {
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

        if (file.path == data['photoBase64']) {
          var multipartFile = http.MultipartFile('photo', stream, length,
              filename: 'photo.jpg');
          request.files.add(multipartFile);
        } else {
          var multipartFile = http.MultipartFile('file', stream, length,
              filename: basename(file.path));
          request.files.add(multipartFile);
        }
      }
    }

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
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
  }
}
