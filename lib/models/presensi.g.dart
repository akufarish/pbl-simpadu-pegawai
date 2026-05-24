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
