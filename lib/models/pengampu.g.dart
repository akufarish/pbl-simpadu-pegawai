// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pengampu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pengampu _$PengampuFromJson(Map<String, dynamic> json) => Pengampu(
  pengampuId: json['pengampu_id'] as String,
  mataKuliah: MataKuliah.fromJson(json['mata_kuliah'] as Map<String, dynamic>),
  dosen: Dosen.fromJson(json['dosen'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PengampuToJson(Pengampu instance) => <String, dynamic>{
  'pengampu_id': instance.pengampuId,
  'mata_kuliah': instance.mataKuliah,
  'dosen': instance.dosen,
};

MataKuliah _$MataKuliahFromJson(Map<String, dynamic> json) => MataKuliah(
  id: json['id'] as String,
  kode: json['kode'] as String,
  name: json['name'] as String,
  sks: (json['sks'] as num).toInt(),
);

Map<String, dynamic> _$MataKuliahToJson(MataKuliah instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kode': instance.kode,
      'name': instance.name,
      'sks': instance.sks,
    };

Dosen _$DosenFromJson(Map<String, dynamic> json) => Dosen(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$DosenToJson(Dosen instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
};
