import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/utils/api_client.dart';

class PresensiService {
  final String kelompok1Url = dotenv.get("KELOMPOK_1_BASE_URL");

  Future<String?> createPresensiMahasiswa(PresensiRequest payload) async {
    try {
      final response = await ApiClient().dio.post(
        "$kelompok1Url/api/presensi/mahasiswa",
        data: payload.toJson(),
      );

      if (response.statusCode == 201) {
        return null;
      }

      return "Gagal menyimpan data (Status: ${response.statusCode})";
    } on DioException catch (e) {
      if (e.response != null) {
        final errorMessage =
            e.response?.data['message'] ?? "Terjadi kesalahan server";
        final errorDetail = e.response?.data['error'] ?? "";
        return "$errorMessage $errorDetail".trim();
      }
      return "Koneksi gagal: ${e.message}";
    } catch (e) {
      return "Terjadi kesalahan sistem: $e";
    }
  }

  Future<PresensiPegawaiResponse> getPresensi() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final response = await ApiClient().dio.get(
      "$kelompok1Url/api/presensi/pegawai?date=$formattedDate",
    );

    try {
      if (response.statusCode == 200) {
        final result = ApiResponse<PresensiPegawaiResponse>.fromJson(
          response.data,
          (json) =>
              PresensiPegawaiResponse.fromJson(json as Map<String, dynamic>),
        );
        debugPrint("Get data presesnsi: ${result.data}");
        return result.data!;
      } else {
        throw Exception('samting wong');
      }
    } on DioException catch (e) {
      throw Exception('Samting wong: $e');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<bool> createSesi() async {
    final response = await ApiClient().dio.post(
      "$kelompok1Url/api/presensi/pegawai",
    );

    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('samting wong');
      }
    } on DioException catch (e) {
      throw Exception('Samting wong: $e');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<PresensiResponse> getPresensiMahasiswa(String id) async {
    try {
      final response = await ApiClient().dio.get(
        "$kelompok1Url/api/presensi/mahasiswa?sesi_id=$id",
      );
      if (response.statusCode == 200) {
        final result = ApiResponse<PresensiResponse>.fromJson(
          response.data,
          (json) => PresensiResponse.fromJson(json as Map<String, dynamic>),
        );
        debugPrint("Get data presesnsi: ${result.data}");
        return result.data!;
      } else {
        throw Exception('samting wong');
      }
    } on DioException catch (e) {
      throw Exception('Samting wong: $e');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<void> updatePresensi(UpdatePresensiMahasiswa payload) async {
    final Map<String, dynamic> data = {
      "sesi_id": payload.sesiId,
      "detail": [
        {"detail_id": payload.detailId, "status": payload.status.toLowerCase()},
      ],
    };

    try {
      final response = await ApiClient().dio.put(
        "$kelompok1Url/api/presensi/mahasiswa",
        data: data,
      );

      debugPrint("Sukses simpan presensi: ${response.statusCode}");
    } on DioException catch (e) {
      debugPrint(
        "Gagal simpan presensi (${e.response?.statusCode}): ${e.response?.data}",
      );
      throw Exception(
        "Gagal menyimpan presensi: ${e.response?.data ?? e.message}",
      );
    } catch (e) {
      throw Exception("Network Error: $e");
    }
  }
}
