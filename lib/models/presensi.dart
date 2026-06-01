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

@JsonSerializable()
class PresensiPegawai {
  @JsonKey(name: "detail_id")
  final String detailId;
  final String email;
  final String name;

  PresensiPegawai({
    required this.detailId,
    required this.email,
    required this.name,
  });

  factory PresensiPegawai.fromJson(Map<String, dynamic> json) =>
      _$PresensiPegawaiFromJson(json);
  Map<String, dynamic> toJson() => _$PresensiPegawaiToJson(this);
}

@JsonSerializable()
class PresensiPegawaiResponse {
  final List<PresensiPegawai> pegawai;
  @JsonKey(name: "sesi_id")
  final String sesiId;

  PresensiPegawaiResponse({required this.pegawai, required this.sesiId});

  factory PresensiPegawaiResponse.fromJson(Map<String, dynamic> json) =>
      _$PresensiPegawaiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PresensiPegawaiResponseToJson(this);
}
