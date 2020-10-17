// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) {
  return QuestionModel(
    questionLabel: json['questionLabel'] as String,
    questionId: json['questionId'] as String,
    questionType:
        _$enumDecodeNullable(_$QuestionTypeEnumMap, json['questionType']),
    expectedAnswers:
        (json['expectedAnswers'] as List)?.map((e) => e as String)?.toList(),
  )..answer1 = json['answer1'] as String;
}

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'answer1': instance.answer1,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$QuestionTypeEnumMap = {
  QuestionType.TextInput: 'TextInput',
  QuestionType.RadioSelect: 'RadioSelect',
  QuestionType.MultiChoice: 'MultiChoice',
  QuestionType.Automatic: 'Automatic',
};
