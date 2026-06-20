// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tugas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tugas _$TugasFromJson(Map<String, dynamic> json) => Tugas(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  deadline: json['deadline'] as String,
  createdAt: json['created_at'] as String,
  attachment: (json['attachment'] as List<dynamic>?)
      ?.map((e) => Materi.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TugasToJson(Tugas instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'deadline': instance.deadline,
  'created_at': instance.createdAt,
  'attachment': instance.attachment,
};

TugasRequest _$TugasRequestFromJson(Map<String, dynamic> json) =>
    TugasRequest();

Map<String, dynamic> _$TugasRequestToJson(TugasRequest instance) =>
    <String, dynamic>{};
