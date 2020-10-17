import 'package:access/models/data_result.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/symptoms_page_details_model.dart';
import 'package:access/repositories/personal_details_repository.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:rxdart/rxdart.dart';

class SymptomsBloc {
  final _pageDetailsFetcher = BehaviorSubject<DataResult<SymptomsPageDetailsModel>>();
  Stream<DataResult<SymptomsPageDetailsModel>>
      get pageDetailsStream => _pageDetailsFetcher.stream;

  Future<void> getPersonalDetails() async {
DataResult<PersonalDetailsModel> personalDetailsResult = await PersonalDetailsRepository().getPersonalDetails();

    DataResult<SymptomsPageDetailsModel> dataResult;
    if (personalDetailsResult.success) {
      List<QuestionModel> questions = QuestionFormRepository().getSymptomQuestions();

        dataResult = DataResult(success: true, value: SymptomsPageDetailsModel(personalDetails: personalDetailsResult.value, questions: questions));
    }else{
      dataResult = DataResult(success: false, error: personalDetailsResult.error);
    }

    _pageDetailsFetcher.sink.add(dataResult);

  }

  Future<DataResult<bool>> submitForm() async {
    return QuestionFormRepository().submitForm();
  }  

  dispose() {
    _pageDetailsFetcher.close();
  }
}
