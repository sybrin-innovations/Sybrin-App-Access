import 'package:access/repositories/personal_details_repository.dart';

class PersonalDetailsDrawerBloc {
  Future<void> deletePersonalDetails() async {
    return await PersonalDetailsRepository().clearPersonalDetails();
  }
}
