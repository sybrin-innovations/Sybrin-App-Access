
import 'package:access/models/form_model.dart';

class QuestionFormRepository {
  static final QuestionFormRepository _addressDetailsRepository =
      QuestionFormRepository._internal();
  QuestionFormRepository._internal();

  factory QuestionFormRepository() {
    return _addressDetailsRepository;
  }

  FormModel _formModel;

  FormModel get getFormModel => _formModel;

  void setFormModel(FormModel model){
    _formModel = model;
  }

  void dispose() {
    this._formModel = null;
  }
}