import 'package:access/blocs/symptoms_bloc.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/models/three_pair.dart';
import 'package:access/pages/add_personal_details_page.dart';
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

  @override
  void initState() {
    _symptomsBloc.getPersonalDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
          children: [Text("Got Symptoms?"), _buildCheckList(symptoms)],
        ),
      ),
    );
  }

  Widget _buildCheckList(List<String> symptoms) {
    return Column(
        children: List.generate(symptoms.length, (index) {
      return CheckboxListTile(
          title: Text(symptoms[index]),
          value: checkValue,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (value) {
            setState(() {
              checkValue = value;
            });
          });
    }));
  }
}
