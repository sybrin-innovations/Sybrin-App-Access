import 'package:json_annotation/json_annotation.dart';

part 'form_model.g.dart';

@JsonSerializable()
class FormModel {
  final String url;
  @JsonKey()
  String answers;
  @JsonKey()
  final DateTime startDate;
  @JsonKey()
  DateTime submitDate;

  FormModel(this.url, this.answers, this.startDate, this.submitDate);

  factory FormModel.fromJson(Map<String, dynamic> json) =>
      _$FormModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormModelToJson(this);
}
