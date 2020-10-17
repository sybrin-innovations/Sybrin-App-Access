
import 'package:access/enums/question_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  final String questionLabel;
  final QuestionType questionType;
  final List<String> expectedAnswers;

  @JsonKey()
  final String questionId;
  @JsonKey()
  String answer1;

  QuestionModel({this.questionLabel, this.questionId, this.questionType, this.expectedAnswers});

  void answer(String answer){
    this.answer1 = answer;
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this); 
}