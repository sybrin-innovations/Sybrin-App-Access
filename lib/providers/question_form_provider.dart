import 'package:access/models/question_model.dart';

class QuestionFormProvider{

  QuestionModel _name = QuestionModel(
    "Name",
    "ree379c6b3c524c89831dfaa1db35242a",
    "",
  );

  QuestionModel _surname = QuestionModel(
    "Surname",
    "r81b61549d945474386bd79adc737b343",
    "",
  );

  QuestionModel _cellNumber = QuestionModel(
    "Cell Number",
    "r9f7dcc2b2c7a4780a142084012a825df",
    "",
  );

  QuestionModel _submitDate = QuestionModel(
    "Submition Date",
    "ra88c365d73d44c68b4a83dc212d1e7f8",
    "",
  );

  QuestionModel _covid = QuestionModel(
    "Got Covid?",
    "r70bd2cd5ce10422eaa3af29f1d3bb090",
    "",
  );

  QuestionModel _quarintine = QuestionModel(
    "Gotta Quarintine?",
    "rb5b426b63ed747a7bd558c749a8ce21c",
    "",
  );

  QuestionModel _symptoms = QuestionModel(
    "Got Symptoms?",
    "r510a20ed4b594fd984258e5f1c168ab2",
    "",
  );

  List<QuestionModel> getPersonalDetailsQuestions(){
      List<QuestionModel> list = List<QuestionModel>();

      list.add(_name);
      list.add(_surname);
      list.add(_cellNumber);
      list.add(_submitDate);

      return list;
  }

  List<QuestionModel> getSelfDeclarationQuestions(){
      List<QuestionModel> list = List<QuestionModel>();

      list.add(_covid);
      list.add(_quarintine);

      return list;
  }

  List<QuestionModel> getSymptomsQuestions(){
      List<QuestionModel> list = List<QuestionModel>();

      list.add(_symptoms);

      return list;
  }

  List<String> getSymptoms(){
    List<String> symptoms = List<String>();

    symptoms.add("Fever");
    symptoms.add("Chills");
    symptoms.add("Cough");
    symptoms.add("Sore throat");
    symptoms.add("Shortness of breath");
    symptoms.add("Runny nose");
    symptoms.add("Loss of sens of smell");
    symptoms.add("None of the above");

    return symptoms;
  }

  void dispose(){
    _name.answer("");
    _surname.answer("");
    _cellNumber.answer("");
    _covid.answer("");
    _quarintine.answer("");
    _symptoms.answer("");
  }
}