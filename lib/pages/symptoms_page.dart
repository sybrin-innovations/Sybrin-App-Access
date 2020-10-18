import 'package:access/blocs/symptoms_bloc.dart';
import 'package:access/enums/alert_type.dart';
import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/models/data_result.dart';
import 'package:access/models/error_arguments_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/symptoms_page_details_model.dart';
import 'package:access/pages/error_page.dart';
import 'package:access/pages/landing_page.dart';
import 'package:access/pages/welcome_page.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:access/widgets/alert_popup.dart';
import 'package:access/widgets/checkbox_list_widget.dart';
import 'package:access/widgets/drawer_scaffold.dart';
import 'package:access/widgets/form_card.dart';
import 'package:access/widgets/gradient_button.dart';
import 'package:access/widgets/loader_widget.dart';
import 'package:access/widgets/personal_details_drawer.dart';
import 'package:access/widgets/sybrin_background_widget.dart';
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
    return _loading
        ? _buildLoader("Making magic happen.")
        : StreamBuilder(
            stream: this._symptomsBloc.pageDetailsStream,
            builder: (BuildContext context,
                AsyncSnapshot<DataResult<SymptomsPageDetailsModel>>
                    snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.success) {
                  return DrawerScaffold(
                    title: "Symptoms",
                    drawer: PersonalDetailsDrawer(
                      model: snapshot.data.value.personalDetails,
                    ),
                    body: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          //Swipe from left to right
                          if (details.delta.dx > 0) {
                            Navigator.pop(context);
                            dispose();
                          }

                          //Swipe from right to left
                          if (details.delta.dx < 0 && !_loading) {
                            if (_formFilled) {
                              print("SWIPED");
                              onSubmit();
                            }
                          }
                        },
                        child: _buildBody(snapshot.data.value.questions)),
                  );
                }
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    Navigator.pushReplacementNamed(context, ErrorPage.route,
                        arguments: ErrorArgumentsModel(
                            errorMessage: snapshot.data.error)));
                return _buildLoader("Procedurally generating contents");
              } else {
                return _buildLoader("Procedurally generating contents");
              }
            },
          );
  }

  Widget _buildLoader(String text) {
    return Scaffold(
      body: LoaderWidget(text: text),
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

    return Stack(
      children: [
        SybrinBackgroundWidget(
          withColor: false,
        ),
        Padding(
          padding: EdgeInsets.only(top: 80),
          child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: FormCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: bodyColumn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildSubmitButton(),
                ],
              )),
        )
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: GradientButton(
        onPressed: _formFilled ? onSubmit : null,
        title: "Submit".toUpperCase(),
        gradient: SybrinGradients.getLinearGradient(context),
      ),
    );
  }

  bool _formFilled = false;
  void _answerCheckQuestion(QuestionModel question, List<String> answers) {
    String symptomsAnswer = "[";
    String filler = '"';

    for (var i = 0; i < answers.length; i++) {
      symptomsAnswer = symptomsAnswer + filler + answers[i] + filler + ",";
    }

    symptomsAnswer =
        symptomsAnswer.substring(0, symptomsAnswer.length - 1) + "]";

    question.answer(symptomsAnswer);

    setState(() {
      if (answers.isNotEmpty) {
        _formFilled = true;
      } else {
        _formFilled = false;
      }
    });
  }

  void onSubmit() async {
    setState(() {
      _loading = true;
    });

    DataResult<bool> dataResult = await this._symptomsBloc.submitForm();

    if (dataResult.success) {
      QuestionFormRepository().dispose();
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomePage.route, ModalRoute.withName(LandingPage.route));
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

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
