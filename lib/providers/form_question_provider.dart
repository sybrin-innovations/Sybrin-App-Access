import 'package:access/enums/question_type.dart';
import 'package:access/models/question_model.dart';

class FormQuestionProvider {
  static QuestionModel _name = QuestionModel(
      questionId: "ree379c6b3c524c89831dfaa1db35242a",
      questionLabel: "Name",
      questionType: QuestionType.TextInput);

  static QuestionModel _surname = QuestionModel(
      questionId: "r81b61549d945474386bd79adc737b343",
      questionLabel: "Surname",
      questionType: QuestionType.TextInput);

  static QuestionModel _cellNumber = QuestionModel(
      questionId: "r9f7dcc2b2c7a4780a142084012a825df",
      questionLabel: "Cell Number",
      questionType: QuestionType.TextInput);

  static QuestionModel _submitDate = QuestionModel(
      questionId: "ra88c365d73d44c68b4a83dc212d1e7f8",
      questionLabel: "Submition Date",
      questionType: QuestionType.Automatic);

  static QuestionModel _covid = QuestionModel(
      questionId: "r70bd2cd5ce10422eaa3af29f1d3bb090",
      questionLabel: "Got Covid?",
      questionType: QuestionType.RadioSelect,
      expectedAnswers: ["Yes", "No"]);

  static QuestionModel _quarintine = QuestionModel(
      questionId: "rb5b426b63ed747a7bd558c749a8ce21c",
      questionLabel: "Gotta Quarintine?",
      questionType: QuestionType.RadioSelect,
      expectedAnswers: ["Yes", "No"]);

  static List<String> _symptomsList = [
    "Fever",
    "Chills",
    "Cough",
    "Sore throat",
    "Shortness of breath",
    "Runny nose",
    "Loss of sens of smell",
    "None of the above"
  ];

  static QuestionModel _symptoms = QuestionModel(
      questionId: "r510a20ed4b594fd984258e5f1c168ab2",
      questionLabel: "Got Symptoms?",
      questionType: QuestionType.MultiChoice,
      expectedAnswers: _symptomsList);

  List<QuestionModel> getPersonalDetailQuestions() {
    List<QuestionModel> list = List<QuestionModel>();

    list.add(_name);
    list.add(_surname);
    list.add(_cellNumber);
    return list;
  }

  QuestionModel getSubitDateQuestion() {
    return _submitDate;
  }

  List<QuestionModel> getSelfDeclarationQuestions() {
    List<QuestionModel> list = List<QuestionModel>();

    list.add(_covid);
    list.add(_quarintine);

    return list;
  }

  List<QuestionModel> getSymptomQuestions() {
    List<QuestionModel> list = List<QuestionModel>();

    list.add(_symptoms);

    return list;
  }

  void dispose() {
    _name.answer("");
    _surname.answer("");
    _cellNumber.answer("");
    _covid.answer("");
    _quarintine.answer("");
    _symptoms.answer("");
  }
}
