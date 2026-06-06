import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/pegawai.dart';
import 'package:pegawai/utils/api_client.dart';

class PegawaiService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<PegawaiResponse> showDataPegawai(String employeeId) async {
    final response = await ApiClient().dio.get(
      "$kelompok2Url/api/employees/$employeeId",
    );
    debugPrint("halo dunia");
    debugPrint("Data hasil pegawai: ${response.data}");
    try {
      if (response.statusCode == 200) {
        final result = ApiResponse<PegawaiResponse>.fromJson(
          response.data,
          (json) => PegawaiResponse.fromJson(json as Map<String, dynamic>),
        );
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

          throw Exception(
            'Network error: ${errorResult.error ?? errorResult.message}',
          );
        } catch (_) {
          throw Exception('Network error: ${e.response?.statusCode}');
        }
      }
      throw Exception('error: ${e.message}');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<bool> updateDataPegawai(
    UpdatePegawaiRequest payload,
    String id,
  ) async {
    try {
      debugPrint("update pegawai payload: $payload");
      final response = await ApiClient().dio.put(
        "$kelompok2Url/api/employees/$id",
        data: payload.toJson(),
      );

      debugPrint("update pegawai: $response");

      if (response.statusCode == 200) {
        debugPrint("update pegawai: ${response.data}");
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
          "update pegawai (Status ${e.response?.statusCode}): ${e.response?.data}",
        );

        try {
          final errorResult = ApiResponse<dynamic>.fromJson(
            e.response!.data,
            (item) => item,
          );
          debugPrint(
            "Update pegawai: ${errorResult.error ?? errorResult.message}",
          );
          return false;
        } catch (_) {
          debugPrint("update pegawai");
          return false;
        }
      } else {
        debugPrint("update pegawai: ${e.message}");
        return false;
      }
    } catch (e) {
      debugPrint("update pegawai: $e");
      return false;
    }
  }
}
