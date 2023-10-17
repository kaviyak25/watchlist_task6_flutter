import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = 'http://5e53a76a31b9970014cf7c8c.mockapi.io/';

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error occurred');
    }
  }
}
