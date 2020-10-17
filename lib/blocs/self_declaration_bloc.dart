import 'package:access/models/data_result.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/self_declaration_page_details_model.dart';
import 'package:access/repositories/personal_details_repository.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:rxdart/rxdart.dart';

class SelfDeclarationBloc {
  final _pageDetailsFetcher =
      BehaviorSubject<DataResult<SelfDeclarationPageDetailsModel>>();
  Stream<DataResult<SelfDeclarationPageDetailsModel>>
      get pageDetailsStream => _pageDetailsFetcher.stream;

  Future<void> getPageDetails() async {
    DataResult<PersonalDetailsModel> personalDetailsResult = await PersonalDetailsRepository().getPersonalDetails();

    DataResult<SelfDeclarationPageDetailsModel> dataResult;
    if (personalDetailsResult.success) {
      List<QuestionModel> questions =
        QuestionFormRepository().getSelfDeclarationQuestions();

        dataResult = DataResult(success: true, value: SelfDeclarationPageDetailsModel(personalDetails: personalDetailsResult.value, questions: questions));
    }else{
      dataResult = DataResult(success: false, error: personalDetailsResult.error);
    }

    _pageDetailsFetcher.sink.add(dataResult);
  }

  void startForm(){
    QuestionFormRepository().setStartTime();
  }

  dispose() {
    _pageDetailsFetcher.close();
    QuestionFormRepository().disposeSelfDeclartions();
  }
}
