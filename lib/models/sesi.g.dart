// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sesi _$SesiFromJson(Map<String, dynamic> json) => Sesi(
  id: json['id'] as String,
  pengampuId: json['pengampu_id'] as String,
  sessionNumber: (json['session_number'] as num).toInt(),
  classId: json['class_id'] as String,
  className: json['class_name'] as String,
  courseCode: json['course_code'] as String,
  courseName: json['course_name'] as String,
  topic: json['topic'] as String?,
  sessionDate: json['session_date'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  status: json['status'] as String,
  isAlreadyOpened: json['is_already_opened'],
  lecturerId: json['lecturer_id'] as String,
  lecturer: LecturerModel.fromJson(json['lecturer'] as Map<String, dynamic>),
  learningMaterials: (json['learning_materials'] as List<dynamic>?)
      ?.map((e) => Tugas.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SesiToJson(Sesi instance) => <String, dynamic>{
  'id': instance.id,
  'pengampu_id': instance.pengampuId,
  'session_number': instance.sessionNumber,
  'class_id': instance.classId,
  'class_name': instance.className,
  'course_code': instance.courseCode,
  'course_name': instance.courseName,
  'topic': instance.topic,
  'session_date': instance.sessionDate,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'status': instance.status,
  'is_already_opened': instance.isAlreadyOpened,
  'lecturer_id': instance.lecturerId,
  'lecturer': instance.lecturer,
  'learning_materials': instance.learningMaterials,
};

LecturerModel _$LecturerModelFromJson(Map<String, dynamic> json) =>
    LecturerModel(
      id: json['id'] as String,
      nip: json['nip'] as String,
      nik: json['nik'] as String,
      employeeName: json['employee_name'] as String,
      address: json['address'] as String?,
      birthPlace: json['birth_place'] as String?,
      birthDate: json['birth_date'] as String?,
      gender: json['gender'] as String,
      phoneNumber: json['phone_number'] as String?,
      villageCode: json['village_code'] as String?,
      districtCode: json['district_code'] as String?,
      cityCode: json['city_code'] as String?,
      provinceCode: json['province_code'] as String?,
      citizenCode: json['citizen_code'] as String?,
    );

Map<String, dynamic> _$LecturerModelToJson(LecturerModel instance) =>
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
      'citizen_code': instance.citizenCode,
    };

UpdateSesiRequest _$UpdateSesiRequestFromJson(Map<String, dynamic> json) =>
    UpdateSesiRequest(
      status: json['status'] as String,
      topic: json['topic'] as String?,
    );

Map<String, dynamic> _$UpdateSesiRequestToJson(UpdateSesiRequest instance) =>
    <String, dynamic>{'topic': instance.topic, 'status': instance.status};
