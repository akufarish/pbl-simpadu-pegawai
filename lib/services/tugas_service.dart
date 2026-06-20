import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/materi.dart';
import 'package:pegawai/models/tugas.dart';
import 'package:pegawai/utils/api_client.dart';

class TugasService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<bool> uploadTugas(List<File> files) async {
    final List<MultipartFile> multipartFiles = [];

    for (var file in files) {
      String fileName = file.path.split('/').last;
      multipartFiles.add(
        await MultipartFile.fromFile(file.path, filename: fileName),
      );
    }

    final payload = FormData.fromMap({"files[]": multipartFiles});

    try {
      final response = await ApiClient().dio.post(
        "$kelompok2Url/api/file-uploads",
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

  Future<List<Materi>> getTugas() async {
    final response = await ApiClient().dio.get(
      "$kelompok2Url/api/file-uploads",
    );

    try {
      if (response.statusCode == 200) {
        final result = ApiResponse<List<Materi>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((item) => Materi.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        debugPrint("Get tugas sesi: ${result.data}");
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

  // Future<bool> buatTugas() async {
  //   try {
  //     final response = await ApiClient().dio.post(
  //       "$kelompok2Url/api/file-uploads",
  //       data: payload,
  //     );

  //     debugPrint("Response sukses: $response");
  //     return true;
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       debugPrint(
  //         "Validasi Gagal (Status ${e.response?.statusCode}): ${e.response?.data}",
  //       );

  //       try {
  //         final errorResult = ApiResponse<dynamic>.fromJson(
  //           e.response!.data,
  //           (item) => item,
  //         );
  //         debugPrint(errorResult.error ?? errorResult.message);
  //         return false;
  //       } catch (_) {
  //         debugPrint("Terjadi kesalahan pada parsing error server");
  //         return false;
  //       }
  //     } else {
  //       debugPrint("Koneksi gagal atau request dibatalkan: ${e.message}");
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint("Gagal total saat proses upload: $e");
  //     return false;
  //   }
  // }

  Future<bool> buatTugas(
    String sesiId,
    List<String> materiId,
    String title,
    String description,
    DateTime deadline,
  ) async {
    final Map<String, dynamic> payload = {
      "file_uuids": materiId,
      "title": title,
      "description": description,
      "deadline": DateFormat('yyyy-MM-dd').format(deadline),
    };
    try {
      final response = await ApiClient().dio.post(
        "$kelompok2Url/api/class-sessions/$sesiId/assignments",
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
