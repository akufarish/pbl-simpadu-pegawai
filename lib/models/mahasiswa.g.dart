// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mahasiswa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MahasiswaResponse _$MahasiswaResponseFromJson(Map<String, dynamic> json) =>
    MahasiswaResponse(
      detailId: json['detail_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$MahasiswaResponseToJson(MahasiswaResponse instance) =>
    <String, dynamic>{
      'detail_id': instance.detailId,
      'name': instance.name,
      'email': instance.email,
    };
