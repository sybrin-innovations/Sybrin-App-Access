import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';

class SelfDeclarationPageDetailsModel{
  final PersonalDetailsModel personalDetails;
  final List<QuestionModel> questions;

  SelfDeclarationPageDetailsModel({this.personalDetails, this.questions});
}