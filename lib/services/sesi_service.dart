import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/utils/api_client.dart';

class SesiService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<List<Sesi>> getSesi() async {
    final response = await ApiClient().dio.get(
      "$kelompok2Url/api/class-sessions",
    );

    try {
      if (response.statusCode == 200) {
        final result = ApiResponse<List<Sesi>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((item) => Sesi.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        debugPrint("Get data sesi: ${result.data}");
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

  Future<bool> updateStatusSesi(
    UpdateSesiRequest payload,
    String idSesi,
  ) async {
    final response = await ApiClient().dio.put(
      "$kelompok2Url/api/class-sessions/$idSesi",
      data: payload.toJson(),
    );

    try {
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      debugPrint('Samting wong: $e');
      return false;
    } catch (e) {
      debugPrint('Network error: $e');
      return false;
    }
  }
}
