import 'package:access/models/pair.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/repositories/personal_details_repository.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:rxdart/rxdart.dart';

class SelfDeclarationBloc {
  final _pageDetailsFetcher =
      BehaviorSubject<Pair<PersonalDetailsModel, List<QuestionModel>>>();
  Stream<Pair<PersonalDetailsModel, List<QuestionModel>>>
      get pageDetailsStream => _pageDetailsFetcher.stream;

  Future<void> getPageDetails() async {
    PersonalDetailsModel model =
        await PersonalDetailsRepository().getPersonalDetails();

    List<QuestionModel> questions =
        QuestionFormRepository().selfDeclarationQuestions;

    _pageDetailsFetcher.sink.add(Pair(model, questions));
  }

  void answerSelfDeclaration(List<QuestionModel> questions) {
    QuestionFormRepository().setSelfDeclarationQuestions(questions);
  }

  void startForm(){
    QuestionFormRepository().setStartTime();
  }

  dispose() {
    _pageDetailsFetcher.close();
  }
}
