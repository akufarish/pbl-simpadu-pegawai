import 'package:json_annotation/json_annotation.dart';
import 'package:pegawai/models/pegawai.dart';
part 'wilayah.g.dart';

@JsonSerializable()
class Wilayah extends Domisili {
  @JsonKey(name: "province_code")
  final Domisili? provinceCode;
  @JsonKey(name: "city_code")
  final Domisili? cityCode;
  @JsonKey(name: "district_code")
  final Domisili? districtCode;

  Wilayah({
    required super.id,
    required super.code,
    required super.name,
    this.provinceCode,
    this.cityCode,
    this.districtCode,
  });

  factory Wilayah.fromJson(Map<String, dynamic> json) =>
      _$WilayahFromJson(json);
  Map<String, dynamic> toJson() => _$WilayahToJson(this);
}
