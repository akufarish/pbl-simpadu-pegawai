import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/utils/api_client.dart';

class PresensiService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<String?> createPresensiMahasiswa(PresensiRequest payload) async {
    try {
      final response = await ApiClient().dio.post(
        "https://be.karlearn.site/api/presensi/mahasiswa",
        data: payload.toJson(),
      );

      debugPrint("Hit presensi: ${response.data}");

      if (response.statusCode == 201) {
        return null;
      } else {
        return "samting wong";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        try {
          final errorResult = ApiResponse<dynamic>.fromJson(
            e.response!.data,
            (item) => item,
          );

          debugPrint("Hit presensi: $errorResult");
          debugPrint("Hit presensi: ${errorResult.message}");
          debugPrint("Hit presensi: ${errorResult.error}");

          return null;
        } catch (_) {
          return "Terjadi kesalahan pada server (${e.response?.statusCode})";
        }
      } else {
        return "Koneksi gagal: ${e.message}";
      }
    } catch (e) {
      debugPrint(e.toString());
      return "Koneksi gagal $e";
    }
  }
}
