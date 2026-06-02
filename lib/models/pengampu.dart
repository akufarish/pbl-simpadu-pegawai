import 'package:json_annotation/json_annotation.dart';
part 'pengampu.g.dart';

@JsonSerializable()
class Pengampu {
  @JsonKey(name: "pengampu_id")
  final String pengampuId;

  @JsonKey(name: "mata_kuliah")
  final MataKuliah mataKuliah;

  final Dosen dosen;

  Pengampu({
    required this.pengampuId,
    required this.mataKuliah,
    required this.dosen,
  });

  factory Pengampu.fromJson(Map<String, dynamic> json) =>
      _$PengampuFromJson(json);
  Map<String, dynamic> toJson() => _$PengampuToJson(this);
}

@JsonSerializable()
class MataKuliah {
  final String id;
  final String kode;
  final String name;
  final int sks;

  MataKuliah({
    required this.id,
    required this.kode,
    required this.name,
    required this.sks,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) =>
      _$MataKuliahFromJson(json);
  Map<String, dynamic> toJson() => _$MataKuliahToJson(this);
}

@JsonSerializable()
class Dosen {
  final String id;
  final String name;
  final String email;

  Dosen({required this.id, required this.name, required this.email});

  factory Dosen.fromJson(Map<String, dynamic> json) => _$DosenFromJson(json);
  Map<String, dynamic> toJson() => _$DosenToJson(this);
}
