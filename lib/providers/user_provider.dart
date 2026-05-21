import 'package:flutter/material.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  final AuthService authService = AuthService();
  bool isLoading = false;
  UserResponse? _data;
  UserResponse? get data => _data;

  Future<String?> login(LoginRequest payload) async {
    isLoading = true;
    notifyListeners();
    try {
      String? isSuccess = await authService.login(payload);
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return "Terjadi kesalahan pada sistem";
    }
  }

  Future<bool> logout() async {
    isLoading = false;
    notifyListeners();
    try {
      bool isSuccess = await authService.logout();
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> profile() async {
    isLoading = false;
    notifyListeners();
    try {
      _data = await authService.profile();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
    }
  }
}
