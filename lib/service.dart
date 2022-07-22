import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Service {
  final _host = kReleaseMode ? "http://web.daocacao.me" : "http://0.0.0.0:8080";

  Future<String> signUp(String username, String password) async {
    final response = await post(
      Uri.parse("$_host/sign_up"),
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      final body = jsonDecode(response.body) as Map;
      return body["token"];
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> signIn(String username, String password) async {
    final response = await post(
      Uri.parse("$_host/sign_in"),
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      final body = jsonDecode(response.body) as Map;
      return body["token"];
    } else {
      throw Exception(response.body);
    }
  }
}
