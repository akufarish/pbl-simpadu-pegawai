import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/pengampu.dart';
import 'package:pegawai/utils/api_client.dart';
import 'package:pegawai/utils/token_manager.dart';

class PengampuService {
  final String kelompok1Url = dotenv.get("KELOMPOK_1_BASE_URL");

  Future<List<Pengampu>> getPengampu() async {
    String? detailId = await TokenManager.getDetailId();
    debugPrint("detail id: $detailId");

    try {
      final response = await ApiClient().dio.get(
        "$kelompok1Url/api/pengampu/dosen/$detailId",
      );
      debugPrint("data pengampu: ${response.data}");
      if (response.statusCode == 200) {
        final result = ApiResponse<List<Pengampu>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((item) => Pengampu.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        debugPrint("Get data pengampu: ${result.data}");
        return result.data!;
      } else {
        throw Exception('samting wong');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        try {
          final errorResult = ApiResponse<dynamic>.fromJson(
            e.response!.data,
            (item) => item,
          );

          throw Exception(errorResult.error ?? errorResult.message);
        } catch (_) {
          throw Exception("Terjadi kesalahan pada server (${e.response})");
        }
      }
      throw Exception('Samting wong: $e');
    } catch (e) {
      throw Exception('Error pengmpu: $e');
    }
  }
}
