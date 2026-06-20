import 'package:json_annotation/json_annotation.dart';
import 'package:pegawai/models/materi.dart';
part 'tugas.g.dart';

@JsonSerializable()
class Tugas {
  final String id;
  final String title;
  final String? description;
  final String deadline;
  @JsonKey(name: "created_at")
  final String createdAt;
  final List<Materi>? attachment;

  Tugas({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.createdAt,
    this.attachment,
  });

  factory Tugas.fromJson(Map<String, dynamic> json) => _$TugasFromJson(json);
  Map<String, dynamic> toJson() => _$TugasToJson(this);
}

@JsonSerializable()
class TugasRequest {}
