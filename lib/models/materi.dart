import 'package:json_annotation/json_annotation.dart';
part 'materi.g.dart';

@JsonSerializable()
class Materi {
  final String id;
  @JsonKey(name: "original_file_name")
  final String originaFileName;
  @JsonKey(name: "file_size")
  final int fileSize;
  @JsonKey(name: "mime_type")
  final String mimeType;
  @JsonKey(name: "uploaded_at")
  final String uploadedAt;

  Materi({
    required this.id,
    required this.originaFileName,
    required this.fileSize,
    required this.mimeType,
    required this.uploadedAt,
  });

  factory Materi.fromJson(Map<String, dynamic> json) => _$MateriFromJson(json);
  Map<String, dynamic> toJson() => _$MateriToJson(this);
}
