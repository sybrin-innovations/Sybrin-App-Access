import 'package:access/models/personal_details_model.dart';
import 'package:access/providers/personal_details_provider.dart';

class PersonalDetailsRepository {
  static final PersonalDetailsRepository _addressDetailsRepository =
      PersonalDetailsRepository._internal();
  PersonalDetailsRepository._internal();

  factory PersonalDetailsRepository() {
    return _addressDetailsRepository;
  }

  PersonalDetailsModel _personalDetailsModel;
  PersonalDetailsProvider _personalDetailsProvider = PersonalDetailsProvider();

  Future<void> setPersonalDetails(
      PersonalDetailsModel personalDetailsModel) async {
    this._personalDetailsModel = personalDetailsModel;
    return await _personalDetailsProvider
        .savePersonalDetails(personalDetailsModel);
  }

  Future<void> updatePersonalDetails(
      PersonalDetailsModel personalDetailsModel) async {
    await _personalDetailsProvider.updatePersonalDetails(personalDetailsModel);
    this._personalDetailsModel = personalDetailsModel;
    return;
  }

  Future<PersonalDetailsModel> getPersonalDetails() async {
    if (this._personalDetailsModel == null) {
      this._personalDetailsModel = await _personalDetailsProvider.getPersonalDetails();
    }
    return this._personalDetailsModel;
  }

  Future<void> clearPersonalDetails() async {
    await this._personalDetailsProvider.deletePersonalDetails();
    dispose();
  }

  void dispose() {
    this._personalDetailsModel = null;
  }
}
