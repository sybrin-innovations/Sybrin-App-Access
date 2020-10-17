import 'package:access/models/data_result.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/repositories/personal_details_repository.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:rxdart/rxdart.dart';

class AddPersonalDetailsBloc {
  final _personalDetailQuestionsFetcher =
      BehaviorSubject<List<QuestionModel>>();
  Stream<List<QuestionModel>> get personalDetailQuestionsStream =>
      _personalDetailQuestionsFetcher.stream;

  Future<void> savePersonalDetails(
      PersonalDetailsModel personalDetailsModel) async {
    await PersonalDetailsRepository().setPersonalDetails(personalDetailsModel);
  }

  Future<DataResult<PersonalDetailsModel>> getPersonalDetails() async {
    return PersonalDetailsRepository().getPersonalDetails();
  }

  Future<void> updatePersonalDetails(
      PersonalDetailsModel personalDetailsModel) async {
    return await PersonalDetailsRepository()
        .updatePersonalDetails(personalDetailsModel);
  }

  void getPersonalDetailQuestions() async {
    List<QuestionModel> question = QuestionFormRepository().getPersonalDetailQuestions();

    _personalDetailQuestionsFetcher.sink.add(question);
  }

  void dispose() {
    _personalDetailQuestionsFetcher.close();
  }
}
