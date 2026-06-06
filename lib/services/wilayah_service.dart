import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/pegawai.dart';
import 'package:pegawai/models/wilayah.dart';
import 'package:pegawai/utils/api_client.dart';

class WilayahService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<List<Domisili>?> getDataProvinsi() async {
    try {
      final response = await ApiClient().dio.get("$kelompok2Url/api/provinces");

      debugPrint("get provinsi: $response");

      if (response.statusCode == 200) {
        final result = ApiResponse<List<Domisili>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => Domisili.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
        return result.data;
      } else {
        return null;
      }
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
          return null;
        } catch (_) {
          debugPrint("Terjadi kesalahan pada parsing error server");
          return null;
        }
      } else {
        debugPrint("Koneksi gagal atau request dibatalkan: ${e.message}");
        return null;
      }
    } catch (e) {
      debugPrint("get provinsi $e");
      return null;
    }
  }

  Future<List<Wilayah>?> getDataKota(String provinceCode) async {
    try {
      final response = await ApiClient().dio.get(
        "$kelompok2Url/api/cities/$provinceCode",
      );

      debugPrint("get kota: $response");

      if (response.statusCode == 200) {
        final result = ApiResponse<List<Wilayah>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => Wilayah.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
        return result.data;
      } else {
        return null;
      }
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
          return null;
        } catch (_) {
          debugPrint("Terjadi kesalahan pada parsing error server");
          return null;
        }
      } else {
        debugPrint("Koneksi gagal atau request dibatalkan: ${e.message}");
        return null;
      }
    } catch (e) {
      debugPrint("get kota $e");
      return null;
    }
  }

  Future<List<Wilayah>?> getDataKecamatan(String cityCode) async {
    try {
      final response = await ApiClient().dio.get(
        "$kelompok2Url/api/districts/$cityCode",
      );

      debugPrint("get kota: $response");

      if (response.statusCode == 200) {
        final result = ApiResponse<List<Wilayah>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => Wilayah.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
        return result.data;
      } else {
        return null;
      }
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
          return null;
        } catch (_) {
          debugPrint("Terjadi kesalahan pada parsing error server");
          return null;
        }
      } else {
        debugPrint("Koneksi gagal atau request dibatalkan: ${e.message}");
        return null;
      }
    } catch (e) {
      debugPrint("get kota $e");
      return null;
    }
  }

  Future<List<Wilayah>?> getDataKelurahan(String districtCode) async {
    try {
      final response = await ApiClient().dio.get(
        "$kelompok2Url/api/villages/$districtCode",
      );

      debugPrint("get kota: $response");

      if (response.statusCode == 200) {
        final result = ApiResponse<List<Wilayah>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => Wilayah.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
        return result.data;
      } else {
        return null;
      }
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
          return null;
        } catch (_) {
          debugPrint("Terjadi kesalahan pada parsing error server");
          return null;
        }
      } else {
        debugPrint("Koneksi gagal atau request dibatalkan: ${e.message}");
        return null;
      }
    } catch (e) {
      debugPrint("get kota $e");
      return null;
    }
  }

  Future<List<Domisili>?> getDataNegara() async {
    try {
      final response = await ApiClient().dio.get("$kelompok2Url/api/countries");

      debugPrint("get kota: $response");

      if (response.statusCode == 200) {
        final result = ApiResponse<List<Domisili>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => Domisili.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
        return result.data;
      } else {
        return null;
      }
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
          return null;
        } catch (_) {
          debugPrint("Terjadi kesalahan pada parsing error server");
          return null;
        }
      } else {
        debugPrint("Koneksi gagal atau request dibatalkan: ${e.message}");
        return null;
      }
    } catch (e) {
      debugPrint("get kota $e");
      return null;
    }
  }
}
