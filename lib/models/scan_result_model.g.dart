// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanResultModel _$ScanResultModelFromJson(Map<String, dynamic> json) {
  return ScanResultModel(
    success: json['success'] as bool,
    value: json['value'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ScanResultModelToJson(ScanResultModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'value': instance.value,
      'message': instance.message,
    };
