import 'package:access/blocs/personal_details_drawer_bloc.dart';
import 'package:access/enums/alert_type.dart';
import 'package:access/enums/page_input_state.dart';
import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/widgets/alert_popup.dart';
import 'package:access/widgets/personal_details_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';

class PersonalDetailsDrawer extends StatefulWidget {
  final PersonalDetailsModel model;

  const PersonalDetailsDrawer({Key key, this.model}) : super(key: key);

  @override
  _PersonalDetailsDrawerState createState() => _PersonalDetailsDrawerState();
}

class _PersonalDetailsDrawerState extends State<PersonalDetailsDrawer> {
  final PersonalDetailsDrawerBloc _personalDetailsDrawerBloc =
      PersonalDetailsDrawerBloc();

  String versionNumber = "";

  @override
  void initState() {
    getPackageInfo();
    super.initState();
  }

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionNumber = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.model != null
        ? Drawer(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: <Widget>[
                      _buildHeader(),
                      _buildDetailsText(),
                    ],
                  ),
                ),
                _buildDeleteDetailsButton(),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: SybrinGradients.getLinearGradient(context),
                  ),
                  child: Center(
                    child: Text(
                      "Version : " + versionNumber,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                )
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildDeleteDetailsButton() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlatButton(
        highlightColor: Theme.of(context).errorColor,
        onPressed: _onDeleteDetailsTap,
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(FontAwesomeIcons.trashAlt)),
            Text(
              "Delete Personal Details",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return PersonalDetailsAppBar(
      personalDetails: this.widget.model,
      onEditPressed: _onChangeDetailsTap,
    );
  }

  Widget _buildDetailsText() {
    return Center(
      child: Column(
        children: [
          Text(
            this.widget.model.name + " " + this.widget.model.surname,
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            this.widget.model.cellNumber,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  void _onChangeDetailsTap() {
    Navigator.pushNamed(context, AddPersonalDetailsPage.route,
        arguments: PageInputState.Edit);
  }

  void _onDeleteDetailsTap() {
    AlertPopup.showAlert(
      context: context,
      alertType: AlertType.Info,
      text: "Are your sure you want to delete your personal details?",
      buttonText: "Delete",
    ).then((choice) async {
      if (choice) {
        await this._personalDetailsDrawerBloc.deletePersonalDetails();
        Navigator.pushReplacementNamed(context, SelfDeclarationPage.route);
      }
    });
  }
}
