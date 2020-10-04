import 'package:access/blocs/personal_details_drawer_bloc.dart';
import 'package:access/enums/alert_type.dart';
import 'package:access/enums/page_input_state.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/widgets/alert_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalDetailsDrawer extends StatefulWidget {
  final PersonalDetailsModel model;

  const PersonalDetailsDrawer({Key key, this.model}) : super(key: key);

  @override
  _PersonalDetailsDrawerState createState() => _PersonalDetailsDrawerState();
}

class _PersonalDetailsDrawerState extends State<PersonalDetailsDrawer> {
  final PersonalDetailsDrawerBloc _personalDetailsDrawerBloc =
      PersonalDetailsDrawerBloc();

  @override
  Widget build(BuildContext context) {
    return this.widget.model != null
        ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  padding: EdgeInsets.only(bottom: 20, top: 10),
                  child: Center(
                    child: _buildDetails(),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                ListTile(
                  title: Text('Change personal details'),
                  onTap: () {
                    Navigator.pop(context);
                    _onChangeDetailsTap();
                  },
                ),
                ListTile(
                  title: Text('Delete personal details'),
                  onTap: () {
                    _onDeleteDetailsTap();
                  },
                ),
              ],
            ),
          )
        : null;
  }

  Widget _buildDetails() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: _buildPersonalIcon(),
          ),
          Container(
            height: 20,
          ),
          Text(
            this.widget.model.name + " " + this.widget.model.surname,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            this.widget.model.cellNumber,
            style: TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _buildPersonalIcon() {
    return CircleAvatar(
      radius: 55,
      backgroundColor: Colors.orange,
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: Text(
          this.widget.model.name.substring(0, 1).toUpperCase() +
              this.widget.model.surname.substring(0, 1).toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor, shape: BoxShape.circle),
      ),
    );
  }

  void _onChangeDetailsTap() {
    Navigator.pushReplacementNamed(context, AddPersonalDetailsPage.route,
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
