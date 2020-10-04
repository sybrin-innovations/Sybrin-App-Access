import 'package:access/models/personal_details_model.dart';
import 'package:access/repositories/personal_details_repository.dart';
import 'package:rxdart/rxdart.dart';

class SelfDeclarationBloc{
  final _personalDetailsFetcher = BehaviorSubject<PersonalDetailsModel>();
  Stream<PersonalDetailsModel> get personalDetailsStream =>
      _personalDetailsFetcher.stream;
      
  Future<void> getPersonalDetails() async {
    PersonalDetailsModel model = await PersonalDetailsRepository().getPersonalDetails();

    _personalDetailsFetcher.sink.add(model);
  }

  dispose() {
    _personalDetailsFetcher.close();
  }
}