// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) {
  return QuestionModel(
    json['questionLabel'] as String,
    json['questionId'] as String,
    json['answer1'] as String,
  );
}

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'questionLabel': instance.questionLabel,
      'questionId': instance.questionId,
      'answer1': instance.answer1,
    };
