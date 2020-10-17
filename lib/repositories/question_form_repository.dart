import 'dart:convert';

import 'package:access/handlers/submit_handler.dart';
import 'package:access/models/data_result.dart';
import 'package:access/models/form_model.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/providers/form_question_provider.dart';
import 'package:access/repositories/personal_details_repository.dart';
import 'package:intl/intl.dart';

class QuestionFormRepository {
  static final QuestionFormRepository _addressDetailsRepository =
      QuestionFormRepository._internal();
  QuestionFormRepository._internal();

  factory QuestionFormRepository() {
    return _addressDetailsRepository;
  }

  FormQuestionProvider _questionProvider = FormQuestionProvider();
  DateTime _startTime;
  String _url;
  List<QuestionModel> _personalDetailQuestions;
  List<QuestionModel> _selfDeclarationQuestions;
  List<QuestionModel> _symptomQuestions;
  QuestionModel _submitDateQuestion;

  List<QuestionModel> getPersonalDetailQuestions() {
    this._personalDetailQuestions =
        _questionProvider.getPersonalDetailQuestions();
    return this._personalDetailQuestions;
  }

  List<QuestionModel> getSelfDeclarationQuestions() {
    this._selfDeclarationQuestions =
        _questionProvider.getSelfDeclarationQuestions();
    return this._selfDeclarationQuestions;
  }

  List<QuestionModel> getSymptomQuestions() {
    this._symptomQuestions = _questionProvider.getSymptomQuestions();
    return this._symptomQuestions;
  }

  QuestionModel getSubmitDateQeuestion() {
    this._submitDateQuestion = _questionProvider.getSubitDateQuestion();
    return this._submitDateQuestion;
  }

  void setStartTime() {
    _startTime = DateTime.now();
  }

  void setUrl(String url) {
    this._url = url;
  }

  Future<DataResult<bool>> submitForm() async {
    if (_personalDetailQuestions == null) {
      _personalDetailQuestions = getPersonalDetailQuestions();
      PersonalDetailsModel personalDetails = PersonalDetailsRepository().personalDetails;

      _personalDetailQuestions[0].answer(personalDetails.name);
      _personalDetailQuestions[1].answer(personalDetails.surname);
      _personalDetailQuestions[2].answer(personalDetails.cellNumber);
    }

    if (_submitDateQuestion == null) {
      _submitDateQuestion = getSubmitDateQeuestion();
      _submitDateQuestion
          .answer(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    }

    List<QuestionModel> questions = List<QuestionModel>();
    questions.addAll(_personalDetailQuestions);
    questions.add(_submitDateQuestion);
    questions.addAll(_selfDeclarationQuestions);
    questions.addAll(_symptomQuestions);

    FormModel model = new FormModel(
      _url,
      json.encode(questions),
      _startTime,
      new DateTime.now(),
    );

    SubmitHandler sh = new SubmitHandler();
    DataResult<String> dataResult = await sh.submitData(model);

    if (dataResult.success) {
      return DataResult<bool>(success: true, value: true);
    } else {
      return DataResult<bool>(
          success: false, value: false, error: dataResult.error);
    }
  }

  void dispose() {
    _startTime = null;
    _url = null;
    _personalDetailQuestions = null;
    _selfDeclarationQuestions = null;
    _symptomQuestions = null;

    this._questionProvider.dispose();
  }

  void disposeSelfDeclartions() {
    _selfDeclarationQuestions = null;
  }
}
