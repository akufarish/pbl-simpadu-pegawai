import 'package:json_annotation/json_annotation.dart';
part 'tugas.g.dart';

@JsonSerializable()
class Tugas {
  final String id;
  @JsonKey(name: "original_file_name")
  final String originaFileName;
  @JsonKey(name: "file_size")
  final int fileSize;
  @JsonKey(name: "mime_type")
  final String mimeType;
  @JsonKey(name: "uploaded_at")
  final String uploadedAt;

  Tugas({
    required this.id,
    required this.originaFileName,
    required this.fileSize,
    required this.mimeType,
    required this.uploadedAt,
  });

  factory Tugas.fromJson(Map<String, dynamic> json) => _$TugasFromJson(json);
  Map<String, dynamic> toJson() => _$TugasToJson(this);
}

@JsonSerializable()
class TugasRequest {}
