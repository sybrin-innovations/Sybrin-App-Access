
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  final String questionLabel;
  @JsonKey()
  final String questionId;
  @JsonKey()
  String answer1;

  QuestionModel(this.questionLabel, this.questionId, this.answer1);

  void answer(String answer){
    this.answer1 = answer;
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this); 
}