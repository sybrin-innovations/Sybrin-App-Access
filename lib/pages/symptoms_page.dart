import 'package:access/blocs/symptoms_bloc.dart';
import 'package:access/enums/alert_type.dart';
import 'package:access/models/data_result.dart';
import 'package:access/models/error_arguments_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/symptoms_page_details_model.dart';
import 'package:access/pages/error_page.dart';
import 'package:access/pages/landing_page.dart';
import 'package:access/pages/thanks_page.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:access/widgets/alert_popup.dart';
import 'package:access/widgets/checkbox_list_widget.dart';
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
  bool _loading = false;

  @override
  void initState() {
    _symptomsBloc.getPersonalDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: dispose,
      child: _loading
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : StreamBuilder(
              stream: this._symptomsBloc.pageDetailsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<DataResult<SymptomsPageDetailsModel>>
                      snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.success) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text("Self Declaration"),
                      ),
                      drawer: PersonalDetailsDrawer(
                        model: snapshot.data.value.personalDetails,
                      ),
                      body: _buildBody(snapshot.data.value.questions),
                    );
                  }
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      Navigator.pushReplacementNamed(context, ErrorPage.route,
                          arguments: ErrorArgumentsModel(
                              errorMessage: snapshot.data.error)));
                  return null;
                } else {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
    );
  }

  Widget _buildBody(List<QuestionModel> questions) {
    List<Widget> bodyColumn = List.generate(questions.length, (index) {
      return CheckboxListWidget(
        title: questions[index].questionLabel,
        selectionItems: questions[index].expectedAnswers,
        cancelationValue: questions[index].expectedAnswers.last,
        onChanged: (checkedAnswers) =>
            _answerCheckQuestion(questions[index], checkedAnswers),
      );
    });

    bodyColumn.add(RaisedButton(
      child: Text("Submit"),
      onPressed: () => onSubmit(),
    ));

    return Container(
      padding: EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bodyColumn,
        ),
      ),
    );
  }

  void _answerCheckQuestion(QuestionModel question, List<String> answers) {
    String symptomsAnswer = "[";
    String filler = '"';

    for (var i = 0; i < answers.length; i++) {
      symptomsAnswer = symptomsAnswer + filler + answers[i] + filler + ",";
    }

    symptomsAnswer =
        symptomsAnswer.substring(0, symptomsAnswer.length - 1) + "]";

    question.answer(symptomsAnswer);
  }

  void onSubmit() async {
    setState(() {
      _loading = true;
    });

    DataResult<bool> dataResult = await this._symptomsBloc.submitForm();

    if (dataResult.success) {
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
  }

  Future<bool> dispose() async {
    super.dispose();
    _symptomsBloc.dispose();
    return true;
  }
}
