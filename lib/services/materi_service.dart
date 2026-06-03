import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/materi.dart';
import 'package:pegawai/models/tugas.dart';
import 'package:pegawai/utils/api_client.dart';

class MateriService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  // Future<List<Tugas>> getTugas() async {
  //   final response = await ApiClient().dio.get(
  //     "$kelompok2Url/api/file-uploads",
  //   );

  //   try {
  //     if (response.statusCode == 200) {
  //       final result = ApiResponse<List<Tugas>>.fromJson(
  //         response.data,
  //         (json) => (json as List)
  //             .map((item) => Tugas.fromJson(item as Map<String, dynamic>))
  //             .toList(),
  //       );
  //       debugPrint("Get tugas sesi: ${result.data}");
  //       return result.data!;
  //     } else {
  //       throw Exception('samting wong');
  //     }
  //   } on DioException catch (e) {
  //     throw Exception('Samting wong: $e');
  //   } catch (e) {
  //     throw Exception('Network error: $e');
  //   }
  // }

  Future<bool> buatMateri(String sesiId, List<String> materiId) async {
    final Map<String, dynamic> payload = {"file_uuids": materiId};
    try {
      final response = await ApiClient().dio.post(
        "$kelompok2Url/api/class-sessions/$sesiId/learning-materials",
        data: payload,
      );

      debugPrint("Response sukses: $response");
      return true;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
          "Validasi Gagal (Status ${e.response?.statusCode}): ${e.response?.data}",
        );

        try {
          final errorResult = ApiResponse<dynamic>.fromJson(
            e.response!.data,
            (item) => item,
          );
          debugPrint(errorResult.error ?? errorResult.message);
          return false;
        } catch (_) {
          debugPrint("Terjadi kesalahan pada parsing error server");
          return false;
        }
      } else {
        debugPrint("Koneksi gagal atau request dibatalkan: ${e.message}");
        return false;
      }
    } catch (e) {
      debugPrint("Gagal total saat proses upload: $e");
      return false;
    }
  }
}
