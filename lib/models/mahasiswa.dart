import 'package:json_annotation/json_annotation.dart';
part 'mahasiswa.g.dart';

@JsonSerializable()
class MahasiswaResponse {
  @JsonKey(name: "detail_id")
  final String detailId;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "email")
  final String email;

  final String status;

  MahasiswaResponse({
    required this.detailId,
    required this.email,
    required this.name,
    required this.status,
  });

  factory MahasiswaResponse.fromJson(Map<String, dynamic> json) =>
      _$MahasiswaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MahasiswaResponseToJson(this);
}
