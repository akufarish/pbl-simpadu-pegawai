import 'package:flutter/material.dart';
import 'package:pegawai/services/materi_service.dart';

class MateriProvider with ChangeNotifier {
  bool isLoading = false;
  MateriService materiService = MateriService();
  Future<bool> uploadMateri(String sesiId, List<String> materiId) async {
    isLoading = true;
    notifyListeners();
    try {
      await materiService.buatMateri(sesiId, materiId);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
