import 'package:access/blocs/symptoms_bloc.dart';
import 'package:access/enums/alert_type.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/three_pair.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/landing_page.dart';
import 'package:access/pages/thanks_page.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:access/widgets/alert_popup.dart';
import 'package:access/widgets/personal_details_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SymptomsPage extends StatefulWidget {
  static const route = '/symptoms';

  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  final SymptomsBloc _symptomsBloc = SymptomsBloc();
  Map<String, bool> symptomAnswers = Map();
  bool initAnswers = true;

  @override
  void initState() {
    _symptomsBloc.getPersonalDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : StreamBuilder(
            stream: this._symptomsBloc.pageDetailsStream,
            builder: (BuildContext context,
                AsyncSnapshot<
                        ThreePair<PersonalDetailsModel, List<QuestionModel>,
                            List<String>>>
                    snapshot) {
              if (snapshot.hasData) {
                if (!snapshot.data.first.hasData) {
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      Navigator.pushReplacementNamed(
                          context, AddPersonalDetailsPage.route));
                }

                return Scaffold(
                  appBar: AppBar(
                    title: Text("Symptoms"),
                  ),
                  drawer: PersonalDetailsDrawer(
                    model: snapshot.data.first,
                  ),
                  body: _buildBody(snapshot.data.third, snapshot.data.second),
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

  bool checkValue = false;

  Widget _buildBody(
      List<String> symptoms, List<QuestionModel> symptomsQuestions) {
    return Container(
      padding: EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Got Symptoms?"),
            _buildCheckList(symptoms),
            RaisedButton(
              child: Text("Submit"),
              onPressed: () => onSubmit(symptomsQuestions),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckList(List<String> symptoms) {
    if (initAnswers) {
      symptoms.forEach((element) {
        symptomAnswers[element] = false;
      });
      initAnswers = false;
    }

    return Column(
        children: List.generate(symptoms.length, (index) {
      return CheckboxListTile(
          title: Text(symptoms[index]),
          value: symptomAnswers.values.toList()[index],
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (value) {
            setState(() {
              symptomAnswers[symptoms[index]] = value;
            });
          });
    }));
  }

  void onSubmit(List<QuestionModel> questions) async {
    String symptomsAnswer = "[";
    String filler = '"';

    for (var i = 0; i < symptomAnswers.length; i++) {
      if (symptomAnswers.values.toList()[i]) {
        symptomsAnswer = symptomsAnswer +
            filler +
            symptomAnswers.keys.toList()[i] +
            filler +
            ",";
      }
    }

    symptomsAnswer =
        symptomsAnswer.substring(0, symptomsAnswer.length - 1) + "]";

    questions[0].answer(symptomsAnswer);

    this._symptomsBloc.answerSymptoms(questions);

    setState(() {
      _loading = true;
    });

    this._symptomsBloc.submitForm().then((value) {
      if (value) {
        QuestionFormRepository().dispose();
        Navigator.pushNamedAndRemoveUntil(
            context, ThanksPage.route, ModalRoute.withName(LandingPage.route));
      } else {
        AlertPopup.showAlert(
                context: context,
                alertType: AlertType.Error,
                text: "There was an error processing your form.",
                buttonText: "OK")
            .then((value) {
          setState(() {
            _loading = false;
          });
        });
      }
    });
  }

  bool _loading = false;
}
