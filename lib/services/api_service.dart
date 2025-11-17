import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class ApiService {
  static String _baseUrl = 'http://localhost:8080/api/auth';
  static String? _token;

  static void configure({String? baseUrl, String? token}) {
    if (baseUrl != null && baseUrl.isNotEmpty) {
      _baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    }
    setToken(token);
  }

  static void setToken(String? token) {
    _token = token;
  }

  static Map<String, String> _headers() {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  static Uri _endpoint(String path) {
    final sanitizedPath = path.startsWith('/') ? path.substring(1) : path;
    return Uri.parse('$_baseUrl/$sanitizedPath');
  }

  static Map<String, dynamic> _decodeResponse(http.Response response) {
    final body = response.body.isEmpty ? '{}' : response.body;
    final Map<String, dynamic> data = json.decode(body) as Map<String, dynamic>;

    final bool okFlag = (data['ok'] ?? (response.statusCode >= 200 && response.statusCode < 300)) == true;

    if (response.statusCode >= 200 && response.statusCode < 300 && okFlag) {
      return data;
    }

    final message = data['mensaje'] ?? data['message'] ?? 'Error ${response.statusCode}';
    throw Exception(message);
  }

  static Future<Map<String, dynamic>> login(String correo, String password) async {
    final response = await http.post(
      _endpoint('login'),
      headers: _headers(),
      body: json.encode({
        'correo': correo,
        'contrasena': password,
      }),
    );

    return _decodeResponse(response);
  }

  static Future<Map<String, dynamic>> register(UserModel user) async {
    final response = await http.post(
      _endpoint('registro'),
      headers: _headers(),
      body: json.encode(user.toRegisterJson()),
    );

    return _decodeResponse(response);
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      _endpoint('usuario-actual'),
      headers: _headers(),
    );

    return _decodeResponse(response);
  }

  static Future<void> logout() async {
    try {
      await http.post(
        _endpoint('logout'),
        headers: _headers(),
      );
    } finally {
      _token = null;
    }
  }
}



