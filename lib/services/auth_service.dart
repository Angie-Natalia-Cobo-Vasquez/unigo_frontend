import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'api_service.dart';

class AuthService extends ChangeNotifier {
  AuthService._();

  static final AuthService instance = AuthService._();

  UserModel? _currentUser;
  String? _token;
  bool _isLoading = false;
  String? _error;

  void configure({String? baseUrl, String? token}) {
    ApiService.configure(baseUrl: baseUrl, token: token);
    _token = token;
  }

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // REGISTER
  Future<bool> register(UserModel user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.register(user);
      final ok = response['ok'] == true;

      if (ok) {
        final loginResponse = await ApiService.login(user.correo, user.password);
        final loginOk = loginResponse['ok'] == true;

        if (loginOk) {
          await _handleLoginSuccess(loginResponse);
          return true;
        }

        _error = loginResponse['mensaje']?.toString() ?? 'Error al iniciar sesión tras registrarse';
      } else {
        _error = response['mensaje']?.toString() ?? 'No se pudo registrar al usuario';
      }

      return false;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // LOGIN
  Future<bool> login(String correo, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.login(correo, password);
      final ok = response['ok'] == true;

      if (ok) {
        await _handleLoginSuccess(response);
        return true;
      }

      _error = response['mensaje']?.toString() ?? 'Credenciales inválidas';
      return false;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // PROCESS LOGIN
  Future<void> _handleLoginSuccess(Map<String, dynamic> response) async {
    final data = response['data'];

    if (data is Map<String, dynamic>) {
      _token = data['token']?.toString();

      final usuario = data['usuario'];
      if (usuario is Map<String, dynamic>) {
        _currentUser = UserModel.fromProfile(usuario).copyWith(password: '');
      }
    }

    ApiService.setToken(_token);

    await _loadUserProfile();
  }

  // LOAD PROFILE
  Future<void> _loadUserProfile() async {
    try {
      final response = await ApiService.getProfile();
      final data = response['data'] is Map<String, dynamic>
          ? response['data'] as Map<String, dynamic>
          : response;

      _currentUser = UserModel.fromProfile(data).copyWith(password: '');
    } catch (e) {
      _error = "Error al cargar el perfil";
    }

    notifyListeners();
  }

  Future<bool> updateProfile(UserModel updatedUser) async {
    _currentUser = updatedUser;
    notifyListeners();
    return true;
  }

  // LOGOUT
  Future<void> logout() async {
    ApiService.logout();
    _token = null;
    _currentUser = null;

    notifyListeners();
  }
}

