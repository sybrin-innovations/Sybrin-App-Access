import 'package:access/blocs/self_declaration_bloc.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/symptoms_page.dart';
import 'package:access/widgets/personal_details_drawer.dart';
import 'package:access/widgets/yes_no_radio_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelfDeclarationPage extends StatefulWidget {
  static const route = '/self-declaration';

  @override
  _SelfDeclarationPageState createState() => _SelfDeclarationPageState();
}

class _SelfDeclarationPageState extends State<SelfDeclarationPage> {
  final SelfDeclarationBloc _selfDeclarationBloc = SelfDeclarationBloc();

  String _covidAnswer;
  String _quarintineAnswer;

  @override
  void initState() {
    this._selfDeclarationBloc.getPersonalDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: this._selfDeclarationBloc.personalDetailsStream,
        builder: (BuildContext context,
            AsyncSnapshot<PersonalDetailsModel> snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  Navigator.pushReplacementNamed(
                      context, AddPersonalDetailsPage.route));
            }

            return Scaffold(
              appBar: AppBar(
                title: Text("Self Declaration"),
              ),
              drawer: PersonalDetailsDrawer(
                model: snapshot.data,
              ),
              body: _buildBody(),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            YesNoRadioWidget(
              title: "Got Covid?",
              onChanged: (value) {
                this._covidAnswer = value;
              },
            ),
            YesNoRadioWidget(
              title: "Gotta Quarintine?",
              onChanged: (value) {
                this._quarintineAnswer = value;
              },
            ),
            RaisedButton(
              onPressed: onNext,
              child: Text("Next"),
            )
          ],
        ),
      ),
    );
  }

  void onNext() {
    Navigator.pushReplacementNamed(context, SymptomsPage.route);
  }
}
