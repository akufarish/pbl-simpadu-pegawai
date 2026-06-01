import 'package:flutter/material.dart';
import 'package:pegawai/models/pegawai.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/services/auth_service.dart';
import 'package:pegawai/services/pegawai_service.dart';

class UserProvider with ChangeNotifier {
  final AuthService authService = AuthService();
  final PegawaiService pegawaiService = PegawaiService();
  bool isLoading = false;
  UserResponse? _data;
  UserResponse? get data => _data;
  PegawaiResponse? _dataPegawai;
  PegawaiResponse? get dataPegawai => _dataPegawai;

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
      debugPrint("detail id: ${_data!.detailId}");
      _dataPegawai = await pegawaiService.showDataPegawai(_data!.detailId!);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
    }
  }
}
