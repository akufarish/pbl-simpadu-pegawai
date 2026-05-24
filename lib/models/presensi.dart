import 'package:json_annotation/json_annotation.dart';
import 'package:pegawai/models/mahasiswa.dart';
part 'presensi.g.dart';

@JsonSerializable()
class PresensiRequest {
  @JsonKey(name: "pengampu_id")
  final String pengampuId;
  @JsonKey(name: "sesi_id")
  final String sesiId;

  PresensiRequest({required this.pengampuId, required this.sesiId});

  factory PresensiRequest.fromJson(Map<String, dynamic> json) =>
      _$PresensiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PresensiRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PresensiResponse {
  @JsonKey(name: "sesi_id")
  final String sesiId;
  @JsonKey(name: "pengampu_id")
  final String pengampuId;
  @JsonKey(name: "mahasiswa")
  final List<MahasiswaResponse> mahasiswa;

  PresensiResponse({
    required this.pengampuId,
    required this.sesiId,
    required this.mahasiswa,
  });

  factory PresensiResponse.fromJson(Map<String, dynamic> json) =>
      _$PresensiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PresensiResponseToJson(this);
}
