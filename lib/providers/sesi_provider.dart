import 'package:flutter/material.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/services/sesi_service.dart';

class SesiProvider with ChangeNotifier {
  final SesiService sesiService = SesiService();
  bool isLoading = false;
  List<Sesi>? _data = [];
  List<Sesi>? get data => _data;

  List<Sesi>? _dataKalender;
  List<Sesi>? get dataKalender => _dataKalender;

  Future<void> getDataSesi(String? startDate, String? endDate) async {
    isLoading = true;
    notifyListeners();
    _data = null;
    try {
      _data = await sesiService.getSesi(startDate, endDate);
      debugPrint("hasil pegawai: $_data");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _data = null;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getDataSesiKalender(String? startDate, String? endDate) async {
    isLoading = true;
    notifyListeners();
    _dataKalender = null;
    try {
      _dataKalender = await sesiService.getSesi(startDate, endDate);
      debugPrint("hasil pegawai: $_data");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _dataKalender = null;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getDataSesiByPengampu(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      _data = await sesiService.getSesibyPengampu(id);
      debugPrint("hasil pegawai: $_data");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateSesi(UpdateSesiRequest payload, String id) async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await sesiService.updateStatusSesi(payload, id);
      debugPrint("pls: $isSuccess");
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Map<DateTime, List<Sesi>> getEventsGroupedByDate(List<Sesi> list) {
    Map<DateTime, List<Sesi>> data = {};
    for (var jadwal in list) {
      DateTime date = DateTime.parse(jadwal.sessionDate);
      DateTime normalizedDate = DateTime(date.year, date.month, date.day);

      if (data[normalizedDate] == null) data[normalizedDate] = [];
      data[normalizedDate]!.add(jadwal);
    }
    return data;
  }
}
