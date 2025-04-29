import 'package:flutter/material.dart';
import '../services/firebase_auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _authService = FirebaseAuthService();

  bool isLoading = false;
  bool isSignUp = false;

  void toggleAuthMode() {
    isSignUp = !isSignUp;
    notifyListeners();
  }

  Future<void> signInWithEmail(String email, String password) async {
    _startLoading();
    await _authService.signInWithEmail(email, password);
    _stopLoading();
  }

  Future<void> signUpWithEmail(String email, String password) async {
    _startLoading();
    await _authService.signUpWithEmail(email, password);
    _stopLoading();
  }

  Future<void> signInWithGoogle() async {
    _startLoading();
    await _authService.signInWithGoogle();
    _stopLoading();
  }

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }
}
