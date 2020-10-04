import 'package:access/models/personal_details_model.dart';
import 'package:access/repositories/personal_details_repository.dart';

class AddPersonalDetailsBloc{

  Future<void> registerUser(PersonalDetailsModel personalDetailsModel) async {
    await PersonalDetailsRepository().setPersonalDetails(personalDetailsModel);
  }

  Future<PersonalDetailsModel> getPersonalDetails() async {
    return await PersonalDetailsRepository().getPersonalDetails();
  }

  Future<void> updatePersonalDetails(PersonalDetailsModel personalDetailsModel) async{
      return await PersonalDetailsRepository().updatePersonalDetails(personalDetailsModel);
  }
}