import 'package:json_annotation/json_annotation.dart';
part 'pegawai.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PegawaiResponse {
  final String id;
  final String nip;
  final String nik;
  final String employeeName;
  final String? address;
  final String? birthPlace;
  final String? birthDate;
  final String? gender;
  final String? phoneNumber;
  final String? villageCode;
  final String? districtCode;
  final String? cityCode;
  final String? provinceCode;

  final Domisili? village;
  final Domisili? district;
  final Domisili? city;
  final Domisili? province;

  PegawaiResponse({
    required this.id,
    required this.nip,
    required this.nik,
    required this.employeeName,
    this.address,
    this.birthDate,
    this.birthPlace,
    this.gender,
    this.phoneNumber,
    this.village,
    this.villageCode,
    this.district,
    this.districtCode,
    this.city,
    this.cityCode,
    this.province,
    this.provinceCode,
  });

  factory PegawaiResponse.fromJson(Map<String, dynamic> json) =>
      _$PegawaiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PegawaiResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PegawaiRequest {
  final String nip;
  final String nik;
  final String employeeName;
  final String citizenCode;

  PegawaiRequest({
    required this.nip,
    required this.nik,
    required this.employeeName,
    required this.citizenCode,
  });

  factory PegawaiRequest.fromJson(Map<String, dynamic> json) =>
      _$PegawaiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PegawaiRequestToJson(this);
}

@JsonSerializable()
class Domisili {
  final String id;
  final String code;
  final String name;

  Domisili({required this.id, required this.code, required this.name});

  factory Domisili.fromJson(Map<String, dynamic> json) =>
      _$DomisiliFromJson(json);
  Map<String, dynamic> toJson() => _$DomisiliToJson(this);
}
