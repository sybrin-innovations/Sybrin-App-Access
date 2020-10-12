import 'dart:convert';

import 'package:access/handlers/submit_handler.dart';
import 'package:access/models/data_result.dart';
import 'package:access/models/form_model.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/providers/question_form_provider.dart';
import 'package:access/repositories/personal_details_repository.dart';
import 'package:intl/intl.dart';

class QuestionFormRepository {
  static final QuestionFormRepository _addressDetailsRepository =
      QuestionFormRepository._internal();
  QuestionFormRepository._internal();

  factory QuestionFormRepository() {
    return _addressDetailsRepository;
  }

  QuestionFormProvider _formProvider = QuestionFormProvider();
  DateTime _startTime;
  String _url =
      "https://forms.office.com/formapi/api/1d61f1f2-374b-4a48-8a03-46fc9a907911/users/227560ca-7933-4c1c-bc65-c47fed36f1b1/forms('8vFhHUs3SEqKA0b8mpB5EcpgdSIzeRxMvGXEf-028bFURDAyN0JVMFFHVUFSWVk0WERIWlRXRVRRQy4u')/responses";
  List<QuestionModel> _personalDetails;
  List<QuestionModel> _selfDeclarations;
  List<QuestionModel> _symptoms;

  List<QuestionModel> get personalDetailsQuestions =>
      _formProvider.getPersonalDetailsQuestions();
  List<QuestionModel> get selfDeclarationQuestions =>
      _formProvider.getSelfDeclarationQuestions();
  List<QuestionModel> get symptomsQuestions =>
      _formProvider.getSymptomsQuestions();
  List<String> get symptoms => _formProvider.getSymptoms();

  void setStartTime() {
    _startTime = DateTime.now();
  }

  void setPersonalDetailsQuestions(List<QuestionModel> personalDetails) {
    this._personalDetails = personalDetails;
  }

  void setSelfDeclarationQuestions(List<QuestionModel> selfDeclarations) {
    this._selfDeclarations = selfDeclarations;
  }

  void setSymptomsQuestions(List<QuestionModel> symptoms) {
    this._symptoms = symptoms;
  }

  Future<bool> submitForm() async {
    PersonalDetailsModel personalDetails =
        await PersonalDetailsRepository().getPersonalDetails();
    List<QuestionModel> ques = _formProvider.getPersonalDetailsQuestions();
    ques[0].answer(personalDetails.name);
    ques[1].answer(personalDetails.surname);
    ques[2].answer(personalDetails.cellNumber);
    ques[3].answer(DateFormat('yyyy-MM-dd').format(DateTime.now()));

    _personalDetails = ques;

    List<QuestionModel> questions = List<QuestionModel>();
    questions.addAll(_personalDetails);
    questions.addAll(_selfDeclarations);
    questions.addAll(_symptoms);

    FormModel model = new FormModel(
      _url,
      json.encode(questions),
      _startTime,
      new DateTime.now(),
    );

    SubmitHandler sh = new SubmitHandler();
    DataResult<String> dataResult = await sh.submitData(model);

    if (dataResult.success) {
      return true;
    }

    return false;
  }

  void dispose(){
    _startTime = null;
  _personalDetails = null;
  _selfDeclarations = null;
  _symptoms = null;

  this._formProvider.dispose();
  }
}
