// https://pro-api.coinmarketcap.com/v1/cryptocurrency

import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTP {
  static String get baseUrl =>
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency';
  static final Map<String, String> _headers = Map<String, String>.from(
    {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );

  static Map<String, String> get _getHeaders =>
      Map<String, String>.from(_headers);

  static List<String> headerLog = [];

  static addHeader({
    required String key,
    required String value,
  }) {
    _headers[key] = value;
    headerLog.add("$key: $value");
  }

  static Future<http.Response> post(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    String url = "$baseUrl/$endpoint";
    final response = await http.post(
      Uri.parse(url),
      headers: _getHeaders,
      body: jsonEncode(body),
    );
    return response;
  }

  static Future<http.Response> get(String endpoint) async {
    String url = "$baseUrl/$endpoint";
    final response = await http.get(
      Uri.parse(url),
      headers: _getHeaders,
    );
    return response;
  }

  static Future<http.Response> put(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    String url = "$baseUrl/$endpoint";
    final response = await http.put(
      Uri.parse(url),
      headers: _getHeaders,
      body: jsonEncode(body),
    );
    return response;
  }

  static Future<http.Response> patch(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    String url = "$baseUrl/$endpoint";
    final response = await http.patch(
      Uri.parse(url),
      headers: _getHeaders,
      body: jsonEncode(body),
    );
    return response;
  }

  static Future<http.Response> delete(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    String url = "$baseUrl/$endpoint";
    final response = await http.delete(
      Uri.parse(url),
      headers: _getHeaders,
      body: jsonEncode(body),
    );
    return response;
  }
}
