import 'dart:convert';

import 'package:access/handlers/submit_handler.dart';
import 'package:access/models/data_result.dart';
import 'package:access/models/form_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/providers/question_form_provider.dart';

class QuestionFormRepository {
  static final QuestionFormRepository _addressDetailsRepository =
      QuestionFormRepository._internal();
  QuestionFormRepository._internal();

  factory QuestionFormRepository() {
    return _addressDetailsRepository;
  }

  QuestionFormProvider _formProvider = QuestionFormProvider();
  String _url =
      "https://forms.office.com/formapi/api/1d61f1f2-374b-4a48-8a03-46fc9a907911/users/227560ca-7933-4c1c-bc65-c47fed36f1b1/forms('8vFhHUs3SEqKA0b8mpB5EcpgdSIzeRxMvGXEf-028bFURDAyN0JVMFFHVUFSWVk0WERIWlRXRVRRQy4u')/responses";
  List<QuestionModel> _personalDetails;
  List<QuestionModel> _selfDeclarations;
  List<QuestionModel> _symptoms;

  List<QuestionModel> get personalDetailsQuestions => _formProvider.getPersonalDetailsQuestions();
  List<QuestionModel> get selfDeclarationQuestions => _formProvider.getSelfDeclarationQuestions();
  List<QuestionModel> get symptomsQuestions => _formProvider.getSymptomsQuestions();
  List<String> get symptoms => _formProvider.getSymptoms();

  void setPersonalDetailsQuestions(List<QuestionModel> personalDetails){
    this._personalDetails = personalDetails;
  }

  void setSelfDeclarationQuestions(List<QuestionModel> selfDeclarations){
    this._selfDeclarations = selfDeclarations;
  }

  void setSymptomsQuestions(List<QuestionModel> symptoms){
    this._symptoms = symptoms;
  }

  Future<bool> submitForm() async {
    List<QuestionModel> questions = List<QuestionModel>();
    questions.addAll(_personalDetails);
    questions.addAll(_selfDeclarations);
    questions.addAll(_symptoms);

    FormModel model = new FormModel(
      _url,
      json.encode(questions),
      new DateTime.now().add(new Duration(minutes: -1)),
      new DateTime.now(),
    );

    SubmitHandler sh = new SubmitHandler();
    DataResult<String> dataResult = await sh.submitData(model);

    if (dataResult.success) {
      return true;
    }

    return false;
  }
}
