import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pegawai/models/tugas.dart';
import 'package:pegawai/services/tugas_service.dart';

class TugasProvider with ChangeNotifier {
  bool isLoading = false;
  TugasService tugasService = TugasService();

  late List<Tugas> _data = [];
  List<Tugas> get data => _data;

  Future<void> uploadTugas(List<File> file) async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await tugasService.uploadTugas(file);
      isLoading = false;
      notifyListeners();
      if (isSuccess) {
        await getTugas();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

  Future<void> getTugas() async {
    isLoading = true;
    notifyListeners();
    try {
      _data = await tugasService.getTugas();
      debugPrint("hasil pegawai: $_data");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }
}
