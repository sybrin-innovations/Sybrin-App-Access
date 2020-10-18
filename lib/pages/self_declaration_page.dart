import 'package:access/blocs/self_declaration_bloc.dart';
import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/models/data_result.dart';
import 'package:access/models/error_arguments_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/self_declaration_page_details_model.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/error_page.dart';
import 'package:access/pages/go_home_page.dart';
import 'package:access/pages/symptoms_page.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:access/widgets/drawer_scaffold.dart';
import 'package:access/widgets/form_card.dart';
import 'package:access/widgets/gradient_button.dart';
import 'package:access/widgets/loader_widget.dart';
import 'package:access/widgets/personal_details_drawer.dart';
import 'package:access/widgets/radio_widget.dart';
import 'package:access/widgets/sybrin_background_widget.dart';
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
    return WillPopScope(
      onWillPop: () {
        return clear();
      },
      child: StreamBuilder(
          stream: this._selfDeclarationBloc.pageDetailsStream,
          builder: (BuildContext context,
              AsyncSnapshot<DataResult<SelfDeclarationPageDetailsModel>>
                  snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.success) {
                if (snapshot.data.value.personalDetails == null) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => Navigator.pushReplacementNamed(
                      context,
                      AddPersonalDetailsPage.route,
                    ),
                  );
                  return _buildLoader();
                }

                return DrawerScaffold(
                  title: "Self Declaration",
                  drawer: PersonalDetailsDrawer(
                    model: snapshot.data.value.personalDetails,
                  ),
                  body: GestureDetector(
                      onPanUpdate: (details) {
                        //Swipe from left to right
                        if (details.delta.dx > 0) {
                          Navigator.pop(context);
                          clear();
                        }

                        //Swipe from right to left
                        if (details.delta.dx < 0) {
                          if (_formFilled) {
                            onNext(snapshot.data.value.questions);
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
              return _buildLoader();
            } else {
              return _buildLoader();
            }
          }),
    );
  }

  Widget _buildLoader() {
    return Scaffold(
      body: LoaderWidget(text: "Procedurally generating contents"),
    );
  }

  List<Widget> _buildRadioSelectors(List<QuestionModel> questions) {
    return List.generate(questions.length, (index) {
      return RadioWidget(
        title: questions[index].questionLabel,
        selectionItems: questions[index].expectedAnswers,
        onChanged: (value) {
          questions[index].answer(value);
          isFormFilled(questions);
        },
      );
    });
  }

  Widget _buildBody(List<QuestionModel> questions) {
    List<Widget> bodyColumn = _buildRadioSelectors(questions);

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
                          mainAxisSize: MainAxisSize.max,
                          children: bodyColumn,
                        ),
                      ),
                    ),
                  ),
                ),
                _buildNextButton(questions),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(List<QuestionModel> questions) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: GradientButton(
        onPressed: _formFilled ? () => onNext(questions) : null,
        title: "Next >".toUpperCase(),
        gradient: SybrinGradients.getLinearGradient(context),
      ),
    );
  }

  void isFormFilled(List<QuestionModel> questions) {
    setState(() {
      bool allAnswered = true;
      questions.forEach((question) {
        if (question.answer1 == null || question.answer1.isEmpty) {
          allAnswered = false;
        }
      });

      if (allAnswered) {
        _formFilled = true;
      } else {
        _formFilled = false;
      }
    });
  }

  void onNext(List<QuestionModel> questions) {
    bool goHome = false;

    questions.forEach((question) {
      if (question.answer1 == "Yes") {
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

  Future<bool> clear() async {
    _selfDeclarationBloc.dispose();
    return true;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
