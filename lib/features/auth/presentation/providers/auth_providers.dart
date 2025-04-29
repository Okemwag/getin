import 'package:flutter/material.dart';
import 'package:getin/features/auth/domain/entities/user_entities.dart';
import 'package:getin/features/auth/domain/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  bool _isLoading = false;
  bool _isSignUp = false;
  UserEntity? _user;

  bool get isLoading => _isLoading;
  bool get isSignUp => _isSignUp;
  UserEntity? get user => _user;

  void toggleAuthMode() {
    _isSignUp = !_isSignUp;
    notifyListeners();
  }

  Future<void> signInWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      _user = await authRepository.signInWithEmail(email, password);
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      _user = await authRepository.signUpWithEmail(email, password);
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      _user = await authRepository.signInWithGoogle();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
