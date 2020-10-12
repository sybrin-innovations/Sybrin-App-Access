import 'dart:convert';

import 'package:access/blocs/self_declaration_bloc.dart';
import 'package:access/handlers/submit_handler.dart';
import 'package:access/models/form_model.dart';
import 'package:access/models/pair.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/go_home_page.dart';
import 'package:access/pages/symptoms_page.dart';
import 'package:access/repositories/question_form_repository.dart';
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
  bool _formFilled = false;

  @override
  void initState() {
    this._selfDeclarationBloc.startForm();
    this._selfDeclarationBloc.getPageDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: this._selfDeclarationBloc.pageDetailsStream,
        builder: (BuildContext context,
            AsyncSnapshot<Pair<PersonalDetailsModel, List<QuestionModel>>>
                snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data.first.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  Navigator.pushReplacementNamed(
                      context, AddPersonalDetailsPage.route));
            }

            return Scaffold(
              appBar: AppBar(
                title: Text("Self Declaration"),
              ),
              drawer: PersonalDetailsDrawer(
                model: snapshot.data.first,
              ),
              body: _buildBody(snapshot.data.second),
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

  Widget _buildBody(List<QuestionModel> questions) {
    return Container(
      padding: EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            YesNoRadioWidget(
              title: "Got Covid?",
              onChanged: (value) {
                questions[0].answer(value);
                isFormFilled(questions);
              },
            ),
            YesNoRadioWidget(
              title: "Gotta Quarintine?",
              onChanged: (value) {
                questions[1].answer(value);
                isFormFilled(questions);
              },
            ),
            RaisedButton(
              onPressed: _formFilled ? () => onNext(questions) : null,
              child: Text("Next"),
            )
          ],
        ),
      ),
    );
  }

  void isFormFilled(List<QuestionModel> questions){
    if (questions[0].answer1 != "" && questions[1].answer1 != "") {
      setState(() {
        _formFilled = true;
      });
    }
  }

  void onNext(List<QuestionModel> questions) {
    this._selfDeclarationBloc.answerSelfDeclaration(questions);
    bool goHome = false;

    questions.forEach((element) {
      if (element.answer1 == "Yes") {
        goHome = true;
      }
    });

    if (goHome) {
      QuestionFormRepository().dispose();
      Navigator.pushReplacementNamed(context, GoHomePage.route);
    } else {
      Navigator.pushNamed(context, SymptomsPage.route);
    }
  }
}
