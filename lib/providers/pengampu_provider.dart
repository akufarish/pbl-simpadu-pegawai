import 'package:flutter/material.dart';
import 'package:pegawai/models/pengampu.dart';
import 'package:pegawai/services/pengampu_service.dart';

class PengampuProvider with ChangeNotifier {
  final PengampuService pengampuService = PengampuService();
  bool isLoading = false;
  List<Pengampu>? _data;
  List<Pengampu>? get data => _data;

  Future<void> getPengampu() async {
    isLoading = true;
    notifyListeners();
    try {
      _data = await pengampuService.getPengampu();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
    }
  }
}
