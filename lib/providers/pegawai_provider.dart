import 'package:flutter/material.dart';
import 'package:pegawai/models/pegawai.dart';
import 'package:pegawai/services/pegawai_service.dart';

class PegawaiProvider with ChangeNotifier {
  final PegawaiService pegawaiService = PegawaiService();
  bool isLoading = false;
  PegawaiResponse? _data;
  PegawaiResponse? get data => _data;

  Future<PegawaiResponse?> showDataPegawai(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      PegawaiResponse? isSuccess = await pegawaiService.showDataPegawai(id);
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
