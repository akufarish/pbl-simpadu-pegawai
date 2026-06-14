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

@JsonSerializable()
class PresensiHariIni {
  @JsonKey(name: "created_at")
  final String createdAt;
  final String status;

  PresensiHariIni({required this.createdAt, required this.status});

  factory PresensiHariIni.fromJson(Map<String, dynamic> json) =>
      _$PresensiHariIniFromJson(json);
  Map<String, dynamic> toJson() => _$PresensiHariIniToJson(this);
}

// @JsonSerializable()
// class UpdatePresensiMahasiswa {
//   @JsonKey(name: "sesi_id")
//   String sesiId;
//   @JsonKey(name: "detail_id")
//   String detailId;
//   String status;

//   UpdatePresensiMahasiswa({
//     required this.sesiId,
//     required this.detailId,
//     required this.status,
//   });

//   factory UpdatePresensiMahasiswa.fromJson(Map<String, dynamic> json) =>
//       _$UpdatePresensiMahasiswaFromJson(json);
//   Map<String, dynamic> toJson() => _$UpdatePresensiMahasiswaToJson(this);
// }

@JsonSerializable()
class UpdatePresensiMahasiswa {
  @JsonKey(name: "sesi_id")
  String sesiId;

  List<DetailUpdatePresensiMahassiwa> detail;
  UpdatePresensiMahasiswa({required this.sesiId, required this.detail});

  factory UpdatePresensiMahasiswa.fromJson(Map<String, dynamic> json) =>
      _$UpdatePresensiMahasiswaFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePresensiMahasiswaToJson(this);
}

@JsonSerializable()
class DetailUpdatePresensiMahassiwa {
  @JsonKey(name: "detail_id")
  String detailId;
  String status;

  DetailUpdatePresensiMahassiwa({required this.detailId, required this.status});

  factory DetailUpdatePresensiMahassiwa.fromJson(Map<String, dynamic> json) =>
      _$DetailUpdatePresensiMahassiwaFromJson(json);
  Map<String, dynamic> toJson() => _$DetailUpdatePresensiMahassiwaToJson(this);
}
