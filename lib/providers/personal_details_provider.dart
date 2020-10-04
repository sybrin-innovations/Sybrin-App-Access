import 'package:access/handlers/database_handler.dart';
import 'package:access/models/personal_details_model.dart';

class PersonalDetailsProvider {
  Future<void> savePersonalDetails(PersonalDetailsModel personalDetails) async {
    return DatabaseHandler().insertPersonalDetails(personalDetails);
  }

  Future<PersonalDetailsModel> getPersonalDetails() async {
    return DatabaseHandler().getPersonalDetails();
  }

  Future<void> updatePersonalDetails(
      PersonalDetailsModel personalDetails) async {
    return DatabaseHandler().updatePersonalDetails(personalDetails);
  }

  Future<void> deletePersonalDetails() async {
    return DatabaseHandler().deletePersonalDetails();
  }
}
