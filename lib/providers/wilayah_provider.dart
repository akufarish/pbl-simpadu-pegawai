import 'package:flutter/material.dart';
import 'package:pegawai/models/pegawai.dart';
import 'package:pegawai/models/wilayah.dart';
import 'package:pegawai/services/wilayah_service.dart';

class WilayahProvider with ChangeNotifier {
  bool isLoading = false;
  WilayahService wilayahService = WilayahService();
  List<Domisili>? _dataProvinsi;
  List<Domisili>? get dataProvinsi => _dataProvinsi;
  List<Domisili>? _dataNegara;
  List<Domisili>? get dataNegara => _dataNegara;
  List<Wilayah>? _dataKota;
  List<Wilayah>? get dataKota => _dataKota;
  List<Wilayah>? _dataKecamatan;
  List<Wilayah>? get dataKecamatan => _dataKecamatan;
  List<Wilayah>? _dataKelurahan;
  List<Wilayah>? get dataKelurahan => _dataKelurahan;

  Future<void> getProvinsi() async {
    isLoading = true;
    notifyListeners();
    _dataProvinsi = null;
    try {
      _dataProvinsi = await wilayahService.getDataProvinsi();
      debugPrint("hasil pegawai: $_dataProvinsi");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _dataProvinsi = null;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getNegara() async {
    isLoading = true;
    notifyListeners();
    _dataNegara = null;
    try {
      _dataNegara = await wilayahService.getDataNegara();
      debugPrint("hasil pegawai: $_dataNegara");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _dataNegara = null;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getKota(String id) async {
    notifyListeners();
    _dataKota = null;
    try {
      _dataKota = await wilayahService.getDataKota(id);
      debugPrint("hasil pegawai: $_dataKota");
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _dataKota = null;
      notifyListeners();
    }
  }

  Future<void> getKecamatan(String id) async {
    notifyListeners();
    _dataKecamatan = null;
    try {
      _dataKecamatan = await wilayahService.getDataKecamatan(id);
      debugPrint("hasil pegawai: $_dataKecamatan");
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _dataKecamatan = null;
      notifyListeners();
    }
  }

  Future<void> getKelurahan(String id) async {
    notifyListeners();
    _dataKelurahan = null;
    try {
      _dataKelurahan = await wilayahService.getDataKelurahan(id);
      debugPrint("hasil pegawai: $_dataKelurahan");
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _dataKelurahan = null;
      notifyListeners();
    }
  }
}
