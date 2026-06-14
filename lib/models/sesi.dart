import 'package:json_annotation/json_annotation.dart';
import 'package:pegawai/models/tugas.dart';

part 'sesi.g.dart';

@JsonSerializable()
class Sesi {
  final String id;
  @JsonKey(name: 'pengampu_id')
  final String pengampuId;
  @JsonKey(name: 'session_number')
  final int sessionNumber;
  @JsonKey(name: 'class_id')
  final String classId;
  @JsonKey(name: 'class_name')
  final String className;
  @JsonKey(name: 'course_code')
  final String courseCode;
  @JsonKey(name: 'course_name')
  final String courseName;
  final String? topic;
  @JsonKey(name: 'session_date')
  final String sessionDate;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;
  final String status;
  @JsonKey(name: 'is_already_opened')
  final int isAlreadyOpened;
  @JsonKey(name: 'lecturer_id')
  final String lecturerId;
  final LecturerModel lecturer;
  @JsonKey(name: 'learning_materials')
  final List<Tugas>? learningMaterials;

  Sesi({
    required this.id,
    required this.pengampuId,
    required this.sessionNumber,
    required this.classId,
    required this.className,
    required this.courseCode,
    required this.courseName,
    this.topic,
    required this.sessionDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.isAlreadyOpened,
    required this.lecturerId,
    required this.lecturer,
    this.learningMaterials,
  });

  factory Sesi.fromJson(Map<String, dynamic> json) => _$SesiFromJson(json);
  Map<String, dynamic> toJson() => _$SesiToJson(this);
}

@JsonSerializable()
class LecturerModel {
  final String id;
  final String nip;
  final String nik;
  @JsonKey(name: 'employee_name')
  final String employeeName;
  final String? address;
  @JsonKey(name: 'birth_place')
  final String? birthPlace;
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  final String gender;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'village_code')
  final String? villageCode;
  @JsonKey(name: 'district_code')
  final String? districtCode;
  @JsonKey(name: 'city_code')
  final String? cityCode;
  @JsonKey(name: 'province_code')
  final String? provinceCode;
  @JsonKey(name: 'citizen_code')
  final String? citizenCode;

  LecturerModel({
    required this.id,
    required this.nip,
    required this.nik,
    required this.employeeName,
    this.address,
    this.birthPlace,
    this.birthDate,
    required this.gender,
    this.phoneNumber,
    this.villageCode,
    this.districtCode,
    this.cityCode,
    this.provinceCode,
    this.citizenCode,
  });

  factory LecturerModel.fromJson(Map<String, dynamic> json) =>
      _$LecturerModelFromJson(json);
  Map<String, dynamic> toJson() => _$LecturerModelToJson(this);
}

@JsonSerializable()
class UpdateSesiRequest {
  @JsonKey(name: 'topic')
  final String? topic;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: "is_already_opened")
  final int? isAlreadyOpened;

  UpdateSesiRequest({required this.status, this.topic, this.isAlreadyOpened});

  factory UpdateSesiRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSesiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSesiRequestToJson(this);
}
