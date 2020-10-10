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
        builder: (BuildContext context, AsyncSnapshot<PersonalDetailsModel> snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data.hasData) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => Navigator.pushReplacementNamed(context, AddPersonalDetailsPage.route));
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
    // List<QuestionModel> questions = new List<QuestionModel>();
    // questions.add(new QuestionModel("Name", "ree379c6b3c524c89831dfaa1db35242a", "Test API Name"));
    // questions.add(new QuestionModel("Surname", "r81b61549d945474386bd79adc737b343", "Test API Surname"));
    // questions.add(new QuestionModel("Cell", "r9f7dcc2b2c7a4780a142084012a825df", "Test API Cell"));
    // questions.add(new QuestionModel("Date", "ra88c365d73d44c68b4a83dc212d1e7f8", "2020-10-08"));
    // questions.add(new QuestionModel("Covid?", "r70bd2cd5ce10422eaa3af29f1d3bb090", "No"));
    // questions.add(new QuestionModel("Exposed?", "rb5b426b63ed747a7bd558c749a8ce21c", "No"));
    // questions.add(new QuestionModel("Symptomps", "r510a20ed4b594fd984258e5f1c168ab2", "[\"Fever\",\"Chills\",\"Cough\",\"Sore throat\",\"Shortness of breath\",\"Runny nose\",\"Loss of sense of smell\",\"None of the above\"]"));

    // FormModel model = new FormModel(
    //     "https://forms.office.com/formapi/api/1d61f1f2-374b-4a48-8a03-46fc9a907911/users/227560ca-7933-4c1c-bc65-c47fed36f1b1/forms('8vFhHUs3SEqKA0b8mpB5EcpgdSIzeRxMvGXEf-028bFURDAyN0JVMFFHVUFSWVk0WERIWlRXRVRRQy4u')/responses",
    //     json.encode(questions),
    //     new DateTime.now().add(new Duration(minutes: -1)),
    //     new DateTime.now());

    // SubmitHandler sh = new SubmitHandler();

    // sh.submitData(model);
  }
}
