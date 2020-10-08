import 'package:access/models/question_model.dart';

class FormModel {
  final List<QuestionModel> answers;
  final DateTime startDate;
  final DateTime submitDate;

  FormModel(this.answers, this.startDate, this.submitDate);
}