import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
}
