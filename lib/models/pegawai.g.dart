// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pegawai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PegawaiResponse _$PegawaiResponseFromJson(Map<String, dynamic> json) =>
    PegawaiResponse(
      id: json['id'] as String,
      nip: json['nip'] as String,
      nik: json['nik'] as String,
      employeeName: json['employee_name'] as String,
      address: json['address'] as String?,
      birthDate: json['birth_date'] as String?,
      birthPlace: json['birth_place'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phone_number'] as String?,
      village: json['village'] == null
          ? null
          : Domisili.fromJson(json['village'] as Map<String, dynamic>),
      villageCode: json['village_code'] as String?,
      district: json['district'] == null
          ? null
          : Domisili.fromJson(json['district'] as Map<String, dynamic>),
      districtCode: json['district_code'] as String?,
      city: json['city'] == null
          ? null
          : Domisili.fromJson(json['city'] as Map<String, dynamic>),
      cityCode: json['city_code'] as String?,
      province: json['province'] == null
          ? null
          : Domisili.fromJson(json['province'] as Map<String, dynamic>),
      provinceCode: json['province_code'] as String?,
    );

Map<String, dynamic> _$PegawaiResponseToJson(PegawaiResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nip': instance.nip,
      'nik': instance.nik,
      'employee_name': instance.employeeName,
      'address': instance.address,
      'birth_place': instance.birthPlace,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
      'phone_number': instance.phoneNumber,
      'village_code': instance.villageCode,
      'district_code': instance.districtCode,
      'city_code': instance.cityCode,
      'province_code': instance.provinceCode,
      'village': instance.village?.toJson(),
      'district': instance.district?.toJson(),
      'city': instance.city?.toJson(),
      'province': instance.province?.toJson(),
    };

PegawaiRequest _$PegawaiRequestFromJson(Map<String, dynamic> json) =>
    PegawaiRequest(
      nip: json['nip'] as String,
      nik: json['nik'] as String,
      employeeName: json['employee_name'] as String,
      citizenCode: json['citizen_code'] as String,
    );

Map<String, dynamic> _$PegawaiRequestToJson(PegawaiRequest instance) =>
    <String, dynamic>{
      'nip': instance.nip,
      'nik': instance.nik,
      'employee_name': instance.employeeName,
      'citizen_code': instance.citizenCode,
    };

Domisili _$DomisiliFromJson(Map<String, dynamic> json) => Domisili(
  id: json['id'] as String,
  code: json['code'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$DomisiliToJson(Domisili instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
};
