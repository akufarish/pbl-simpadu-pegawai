import 'package:dio/dio.dart';

class ErrorHandler {
  static Exception handle(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        try {
          final Map<String, dynamic> responseData =
              error.response!.data as Map<String, dynamic>;
          final errorMessage =
              responseData['message'] ?? "Terjadi kesalahan server";
          return Exception(errorMessage);
        } catch (_) {
          return Exception(
            "Terjadi kesalahan pada server (${error.response?.statusCode})",
          );
        }
      }
      return Exception("Koneksi internet bermasalah: ${error.message}");
    }
    return Exception("Terjadi kesalahan sistem: $error");
  }
}
