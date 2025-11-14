import '../models/user.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  User? _registeredUser;
  User? _currentUser;

  User? get registeredUser => _registeredUser;
  User? get currentUser => _currentUser;

  void register(User user) {
    _registeredUser = user;
    _currentUser = user;
  }

  bool login(String email, String password) {
    final user = _registeredUser;
    if (user == null) {
      return false;
    }

    final normalizedEmail = email.trim().toLowerCase();
    final storedEmail = user.email.trim().toLowerCase();

    final isValid =
        normalizedEmail == storedEmail && password.trim() == user.password;
    if (isValid) {
      _currentUser = user;
    }

    return isValid;
  }

  void updateUser(User updatedUser) {
    if (_registeredUser == null) return;
    _registeredUser = updatedUser;
    _currentUser = updatedUser;
  }

  void logout() {
    _currentUser = null;
  }
}
