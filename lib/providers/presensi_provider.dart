import 'package:flutter/material.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/services/presensi_service.dart';

class PresensiProvider with ChangeNotifier {
  final PresensiService presensiService = PresensiService();
  bool isLoading = false;
  PresensiPegawaiResponse? _data;
  PresensiPegawaiResponse? get data => _data;

  PresensiResponse? _presensiMahasiswa;
  PresensiResponse? get presensiMahasiswa => _presensiMahasiswa;

  Future<String?> createPresensiMahasiswa(PresensiRequest payload) async {
    try {
      String? isSuccess = await presensiService.createPresensiMahasiswa(
        payload,
      );
      debugPrint("pls: $isSuccess");
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

  Future<bool> createPresensi() async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await presensiService.createSesi();
      debugPrint("pls: $isSuccess");
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

  Future<void> getDataPresensiPegawai() async {
    isLoading = true;
    notifyListeners();
    try {
      _data = await presensiService.getPresensi();
      debugPrint("hasil presensi: $_data");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getDataPresensiMahasiswa(String id) async {
    isLoading = true;
    _presensiMahasiswa = null;
    notifyListeners();

    try {
      _presensiMahasiswa = await presensiService.getPresensiMahasiswa(id);
      debugPrint("hasil presensi: $_presensiMahasiswa");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("Gagal memuat data presensi: $e");
      _presensiMahasiswa = null;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updatePresensiMahasiswa(UpdatePresensiMahasiswa payload) async {
    isLoading = true;
    notifyListeners();
    try {
      await presensiService.updatePresensi(payload);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Future<bool> updatePresensiMahasiswa(UpdatePresensiMahasiswa payload) async {
  //   isLoading = true;
  //   notifyListeners();
  //   try {
  //     await presensiService.updatePresensi(payload);
  //     isLoading = false;
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     debugPrint("$e");
  //     isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }
}
