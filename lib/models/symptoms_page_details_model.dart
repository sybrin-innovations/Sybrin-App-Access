import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';

class SymptomsPageDetailsModel{
  final PersonalDetailsModel personalDetails;
  final List<QuestionModel> questions;

  SymptomsPageDetailsModel({this.personalDetails, this.questions});
}