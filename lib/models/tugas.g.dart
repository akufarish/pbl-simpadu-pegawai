// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tugas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tugas _$TugasFromJson(Map<String, dynamic> json) => Tugas(
  id: json['id'] as String,
  originaFileName: json['original_file_name'] as String,
  fileSize: (json['file_size'] as num).toInt(),
  mimeType: json['mime_type'] as String,
  uploadedAt: json['uploaded_at'] as String,
);

Map<String, dynamic> _$TugasToJson(Tugas instance) => <String, dynamic>{
  'id': instance.id,
  'original_file_name': instance.originaFileName,
  'file_size': instance.fileSize,
  'mime_type': instance.mimeType,
  'uploaded_at': instance.uploadedAt,
};
