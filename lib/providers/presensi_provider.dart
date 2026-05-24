import 'package:flutter/material.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/services/presensi_service.dart';

class PresensiProvider with ChangeNotifier {
  final PresensiService presensiService = PresensiService();
  bool isLoading = false;

  Future<String?> createPresensiMahasiswa(PresensiRequest payload) async {
    try {
      String? isSuccess = await presensiService.createPresensiMahasiswa(
        payload,
      );
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
}
