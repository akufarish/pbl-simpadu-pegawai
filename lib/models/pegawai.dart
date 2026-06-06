import 'package:json_annotation/json_annotation.dart';
part 'pegawai.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PegawaiResponse {
  final String id;
  final String nip;
  final String nik;
  @JsonKey(name: "employee_name")
  final String employeeName;
  final String? address;
  @JsonKey(name: "birth_place")
  final String? birthPlace;
  @JsonKey(name: "birth_date")
  final String? birthDate;
  final String? gender;
  @JsonKey(name: "phone_number")
  final String? phoneNumber;
  @JsonKey(name: "village_code")
  final String? villageCode;
  @JsonKey(name: "district_code")
  final String? districtCode;
  @JsonKey(name: "city_code")
  final String? cityCode;
  @JsonKey(name: "province_code")
  final String? provinceCode;
  @JsonKey(name: "study_program_id")
  final String? studyProgramId;
  @JsonKey(name: "citizen_code")
  final String? citizenCode;

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
    this.citizenCode,
    this.studyProgramId,
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

@JsonSerializable()
class UpdatePegawaiRequest {
  final String? nip;
  final String? nik;
  @JsonKey(name: "employee_name")
  final String? employeeName;
  @JsonKey(name: "study_program_id")
  final String? studyProgramId;
  @JsonKey(name: "study_program_name")
  final String? studyProgramName;
  final String? address;
  @JsonKey(name: "birth_place")
  final String? birthPlace;
  @JsonKey(name: "birth_date")
  final String? birthDate;
  final String? gender;
  @JsonKey(name: "phone_number")
  final String? phoneNumber;
  @JsonKey(name: "village_code")
  final String? villageCode;
  @JsonKey(name: "district_code")
  final String? districtCode;
  @JsonKey(name: "city_code")
  final String? cityCode;
  @JsonKey(name: "province_code")
  final String? provinceCode;
  @JsonKey(name: "citizen_code")
  final String? citizenCode;
  @JsonKey(name: "image_url")
  final String? imageUrl;

  UpdatePegawaiRequest({
    this.nip,
    this.nik,
    this.employeeName,
    this.address,
    this.birthDate,
    this.birthPlace,
    this.citizenCode,
    this.cityCode,
    this.districtCode,
    this.gender,
    this.phoneNumber,
    this.provinceCode,
    this.studyProgramId,
    this.studyProgramName,
    this.villageCode,
    this.imageUrl,
  });

  factory UpdatePegawaiRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePegawaiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePegawaiRequestToJson(this);
}
