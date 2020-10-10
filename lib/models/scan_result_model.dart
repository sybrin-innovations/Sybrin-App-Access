
import 'package:json_annotation/json_annotation.dart';

part 'scan_result_model.g.dart';

@JsonSerializable()
class ScanResultModel{
  @JsonKey()
  final bool success;

  @JsonKey()
  final String value;

  @JsonKey()
  final String message;

  ScanResultModel({this.success, this.value, this.message});

  factory ScanResultModel.fromJson(Map<String, dynamic> json) =>
      _$ScanResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScanResultModelToJson(this);
}