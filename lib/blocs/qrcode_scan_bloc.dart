import 'package:access/repositories/question_form_repository.dart';

class QRCodeScanBloc{
  void setFormUrl(String url){
    QuestionFormRepository().setUrl(url);
  }
}