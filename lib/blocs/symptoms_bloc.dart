import 'package:access/models/pair.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/three_pair.dart';
import 'package:access/repositories/personal_details_repository.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:rxdart/rxdart.dart';

class SymptomsBloc{
  final _pageDetailsFetcher = BehaviorSubject<ThreePair<PersonalDetailsModel, List<QuestionModel>, List<String>>>();
  Stream<ThreePair<PersonalDetailsModel, List<QuestionModel>, List<String>>> get pageDetailsStream =>
      _pageDetailsFetcher.stream;
      
  Future<void> getPersonalDetails() async {
    PersonalDetailsModel model = await PersonalDetailsRepository().getPersonalDetails();
    List<QuestionModel> questions = QuestionFormRepository().symptomsQuestions;
    List<String> symptoms = QuestionFormRepository().symptoms;
    _pageDetailsFetcher.sink.add(ThreePair(model, questions, symptoms));
  }

  dispose() {
    _pageDetailsFetcher.close();
  }
}