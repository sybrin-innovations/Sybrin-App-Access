import 'package:access/blocs/self_declaration_bloc.dart';
import 'package:access/models/data_result.dart';
import 'package:access/models/error_arguments_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/self_declaration_page_details_model.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/error_page.dart';
import 'package:access/pages/go_home_page.dart';
import 'package:access/pages/symptoms_page.dart';
import 'package:access/repositories/question_form_repository.dart';
import 'package:access/widgets/personal_details_drawer.dart';
import 'package:access/widgets/radio_widget.dart';
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
      onWillPop: dispose,
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
              return _buildLoader();
            } else {
              return _buildLoader();
            }
          }),
    );
  }

  Widget _buildLoader() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
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
    bodyColumn.add(
      RaisedButton(
        onPressed: _formFilled ? () => onNext(questions) : null,
        child: Text("Next"),
      ),
    );

    return Container(
      padding: EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Column(
          children: bodyColumn,
        ),
      ),
    );
  }

  void isFormFilled(List<QuestionModel> questions) {
    setState(() {
          bool allAnswered = true;
        questions.forEach((question) { 
          if ( question.answer1 == null || question.answer1.isEmpty) {
            allAnswered = false;
          }
        });

        if (allAnswered) {
          _formFilled = true;
        }else{
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

  Future<bool> dispose() async {
    super.dispose();
    _selfDeclarationBloc.dispose();
    return true;
  }
}
