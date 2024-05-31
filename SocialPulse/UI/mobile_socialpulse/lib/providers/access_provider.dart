import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AccessProvider extends ChangeNotifier {
  static String? _baseUrl;
  String _endpoint = "api/Access/SignIn";

  AccessProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7185/");
  }

  Future<dynamic> signIn(String em, String ps) async {
    _endpoint = "api/Access/SignIn";
    var url = "$_baseUrl$_endpoint";

    var uri = Uri.parse(url);
    var jsonRequest = jsonEncode({'email': em, 'password': ps});

    Response response = await post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = data;

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<dynamic> signUp(dynamic object) async {
    _endpoint = "api/Access/SignUp";
    var url = "$_baseUrl$_endpoint";

    var uri = Uri.parse(url);

    var jsonRequest = jsonEncode(object);

    Response response = await post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonRequest);

    if (isValidResponse(response)) {
    } else {
      throw Exception("Unknown error");
    }
  }
}

bool isValidResponse(Response response) {
  if (response.statusCode < 299) {
    return true;
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized");
  } else if (response.statusCode == 400) {
    throw Exception("Bad request. Wrong email or password");
  } else {
    throw Exception(
        "Something bad happened please try again, Status code: ${response.statusCode}");
  }
}
