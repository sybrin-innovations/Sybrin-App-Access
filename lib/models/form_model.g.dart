// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormModel _$FormModelFromJson(Map<String, dynamic> json) {
  return FormModel(
    json['url'] as String,
    json['answers'] as String,
    json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    json['submitDate'] == null
        ? null
        : DateTime.parse(json['submitDate'] as String),
  );
}

Map<String, dynamic> _$FormModelToJson(FormModel instance) => <String, dynamic>{
      'answers': instance.answers,
      'startDate': instance.startDate?.toIso8601String().substring(
                  instance.startDate?.toIso8601String().length - 1) ==
              "Z"
          ? instance.startDate?.toIso8601String()
          : instance.startDate?.toIso8601String() + "Z",
      'submitDate': instance.submitDate?.toIso8601String().substring(
                  instance.submitDate?.toIso8601String().length - 1) ==
              "Z"
          ? instance.submitDate?.toIso8601String()
          : instance.submitDate?.toIso8601String() + "Z",
    };
