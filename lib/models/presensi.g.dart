// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presensi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresensiRequest _$PresensiRequestFromJson(Map<String, dynamic> json) =>
    PresensiRequest(
      pengampuId: json['pengampu_id'] as String,
      sesiId: json['sesi_id'] as String,
    );

Map<String, dynamic> _$PresensiRequestToJson(PresensiRequest instance) =>
    <String, dynamic>{
      'pengampu_id': instance.pengampuId,
      'sesi_id': instance.sesiId,
    };

PresensiResponse _$PresensiResponseFromJson(Map<String, dynamic> json) =>
    PresensiResponse(
      pengampuId: json['pengampu_id'] as String,
      sesiId: json['sesi_id'] as String,
      mahasiswa: (json['mahasiswa'] as List<dynamic>)
          .map((e) => MahasiswaResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PresensiResponseToJson(PresensiResponse instance) =>
    <String, dynamic>{
      'sesi_id': instance.sesiId,
      'pengampu_id': instance.pengampuId,
      'mahasiswa': instance.mahasiswa.map((e) => e.toJson()).toList(),
    };

PresensiPegawai _$PresensiPegawaiFromJson(Map<String, dynamic> json) =>
    PresensiPegawai(
      detailId: json['detail_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PresensiPegawaiToJson(PresensiPegawai instance) =>
    <String, dynamic>{
      'detail_id': instance.detailId,
      'email': instance.email,
      'name': instance.name,
    };

PresensiPegawaiResponse _$PresensiPegawaiResponseFromJson(
  Map<String, dynamic> json,
) => PresensiPegawaiResponse(
  pegawai: (json['pegawai'] as List<dynamic>)
      .map((e) => PresensiPegawai.fromJson(e as Map<String, dynamic>))
      .toList(),
  sesiId: json['sesi_id'] as String,
);

Map<String, dynamic> _$PresensiPegawaiResponseToJson(
  PresensiPegawaiResponse instance,
) => <String, dynamic>{'pegawai': instance.pegawai, 'sesi_id': instance.sesiId};

PresensiHariIni _$PresensiHariIniFromJson(Map<String, dynamic> json) =>
    PresensiHariIni(
      createdAt: json['created_at'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PresensiHariIniToJson(PresensiHariIni instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt,
      'status': instance.status,
    };

UpdatePresensiMahasiswa _$UpdatePresensiMahasiswaFromJson(
  Map<String, dynamic> json,
) => UpdatePresensiMahasiswa(
  sesiId: json['sesi_id'] as String,
  detail: (json['detail'] as List<dynamic>)
      .map(
        (e) =>
            DetailUpdatePresensiMahassiwa.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$UpdatePresensiMahasiswaToJson(
  UpdatePresensiMahasiswa instance,
) => <String, dynamic>{'sesi_id': instance.sesiId, 'detail': instance.detail};

DetailUpdatePresensiMahassiwa _$DetailUpdatePresensiMahassiwaFromJson(
  Map<String, dynamic> json,
) => DetailUpdatePresensiMahassiwa(
  detailId: json['detail_id'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$DetailUpdatePresensiMahassiwaToJson(
  DetailUpdatePresensiMahassiwa instance,
) => <String, dynamic>{
  'detail_id': instance.detailId,
  'status': instance.status,
};
