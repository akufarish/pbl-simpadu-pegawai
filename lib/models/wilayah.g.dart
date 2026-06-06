// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wilayah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wilayah _$WilayahFromJson(Map<String, dynamic> json) => Wilayah(
  id: json['id'] as String,
  code: json['code'] as String,
  name: json['name'] as String,
  provinceCode: json['province_code'] == null
      ? null
      : Domisili.fromJson(json['province_code'] as Map<String, dynamic>),
  cityCode: json['city_code'] == null
      ? null
      : Domisili.fromJson(json['city_code'] as Map<String, dynamic>),
  districtCode: json['district_code'] == null
      ? null
      : Domisili.fromJson(json['district_code'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WilayahToJson(Wilayah instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'province_code': instance.provinceCode,
  'city_code': instance.cityCode,
  'district_code': instance.districtCode,
};
