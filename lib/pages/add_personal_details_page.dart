import 'package:access/blocs/add_personal_details_bloc.dart';
import 'package:access/enums/page_input_state.dart';
import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/models/data_result.dart';
import 'package:access/models/error_arguments_model.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/models/question_model.dart';
import 'package:access/pages/error_page.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/utils/pair.dart';
import 'package:access/widgets/form_card.dart';
import 'package:access/widgets/gradient_button.dart';
import 'package:access/widgets/iconized_text_input_widget.dart';
import 'package:access/widgets/personal_details_app_bar.dart';
import 'package:access/widgets/sybrin_background_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:access/extentions/string_validation_extensions.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:uuid/uuid.dart';

class AddPersonalDetailsPage extends StatefulWidget {
  static const route = '/add-personal-details';

  final PageInputState inputState;

  const AddPersonalDetailsPage(
      {Key key, this.inputState = PageInputState.Insert})
      : super(key: key);

  @override
  _AddPersonalDetailsPageState createState() => _AddPersonalDetailsPageState();
}

class _AddPersonalDetailsPageState extends State<AddPersonalDetailsPage> {
  bool _isFormFilled = false;
  PersonalDetailsModel personalDetails;
  AddPersonalDetailsBloc _addPersonalDetailsBloc = AddPersonalDetailsBloc();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TextEditingController> _inputControllers = List<TextEditingController>();
  List<Pair<FocusNode, FocusNode>> _inputFocusNodes =
      List<Pair<FocusNode, FocusNode>>();
  int _cellNumberLength = 10;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    this._addPersonalDetailsBloc.getPersonalDetailQuestions();

    switch (this.widget.inputState) {
      case PageInputState.Edit:
        initTextFields();
        break;
      default:
    }
    super.initState();

    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  void initTextFields() async {
    DataResult<PersonalDetailsModel> dataResult =
        await this._addPersonalDetailsBloc.getPersonalDetails();

    if (dataResult.success) {
      personalDetails = dataResult.value;
      _inputControllers.add(TextEditingController(text: personalDetails.name));
      _inputControllers
          .add(TextEditingController(text: personalDetails.surname));
      _inputControllers
          .add(TextEditingController(text: personalDetails.cellNumber));
      this._isFormFilled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SybrinBackgroundWidget(
            withColor: false,
          ),
          StreamBuilder(
              stream: _addPersonalDetailsBloc.personalDetailQuestionsStream,
              builder: (context, AsyncSnapshot<List<QuestionModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => Navigator.pushReplacementNamed(
                        context,
                        ErrorPage.route,
                        arguments: ErrorArgumentsModel(
                            errorMessage:
                                "There was an error loading the personal details questions."),
                      ),
                    );
                  }

                  return _buildBody(snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }

  List<Widget> _buildInputBoxes(List<QuestionModel> questions) {
    //  Generate focus nodes
    int focusNodesGeneratioinAmount =
        questions.length - _inputFocusNodes.length;
    if (focusNodesGeneratioinAmount > 0) {
      FocusNode previousNode;
      for (var i = 0; i < focusNodesGeneratioinAmount; i++) {
        if (i == 0) {
          FocusNode focusNode = FocusNode();
          _inputFocusNodes.add(Pair(null, focusNode));
          previousNode = focusNode;
          continue;
        }

        if (i == questions.length) {
          _inputFocusNodes.add(Pair(previousNode, null));
          continue;
        }

        FocusNode focusNode = FocusNode();
        _inputFocusNodes.add(Pair(previousNode, focusNode));
        previousNode = focusNode;
      }
    }

    //  Generate Controllers
    int inputControllerGeneratioinAmount =
        questions.length - _inputControllers.length;
    if (inputControllerGeneratioinAmount > 0) {
      for (var i = 0; i < inputControllerGeneratioinAmount; i++) {
        TextEditingController _controller = TextEditingController();
        _inputControllers.add(_controller);
      }
    }

    //  Build input boxes
    return List.generate(questions.length, (index) {
      Function(String) _validateFunction = _validateName;
      TextInputType _inputType = TextInputType.name;

      if (questions[index].questionLabel.toLowerCase().contains("cell")) {
        _validateFunction = _validateCellNumber;
        _inputType = TextInputType.number;
      }

      IconizedTextInputWidget textInput = IconizedTextInputWidget(
        controller: _inputControllers[index],
        formKey: _formKey,
        hint: questions[index].questionLabel,
        textInputType: _inputType,
        validator: _validateFunction,
        focusNode: _inputFocusNodes[index].first,
        nextFocusNode: _inputFocusNodes[index].second,
        onChanged: (text) {
          questions[index].answer(text);
          isFormEmpty();
          _updateLocalPersonalDetails();
        },
      );
      return textInput;
    });
  }

  void _updateLocalPersonalDetails() {
    setState(() {
      if (_inputControllers != null) {
        if(this.personalDetails == null){
          // ignore: missing_required_param
          this.personalDetails = PersonalDetailsModel();
        }
        this.personalDetails.name = _inputControllers[0].text;
        this.personalDetails.surname = _inputControllers[1].text;
        this.personalDetails.cellNumber = _inputControllers[2].text;
      }
    });
  }

  Widget _buildBody(List<QuestionModel> questions) {
    return Column(
      children: [
        PersonalDetailsAppBar(
          personalDetails: personalDetails,
          height: _isKeyboardVisible
              ?  MediaQuery.of(context).size.height * 0.16
              : MediaQuery.of(context).size.height * 0.35,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SingleChildScrollView(
              child: FormCard(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: _buildInputBoxes(questions),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GradientButton(
            gradient: SybrinGradients.getLinearGradient(context),
            onPressed: _isFormFilled ? () => _onSave(questions) : null,
            title: "Save".toUpperCase(),
          ),
        )
      ],
    );
  }

  String _validateName(String postalCode) {
    if (postalCode.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  String _validateCellNumber(String number) {
    if (number.isEmpty) {
      return 'Field is required';
    }

    if (number.length != _cellNumberLength) {
      return 'Not a valid cellphone number';
    }

    if (!number.isNumeric) {
      return 'Not a valid cellphone number';
    }

    return null;
  }

  void isFormEmpty() {
    setState(() {
      _isFormFilled = true;
      _inputControllers.forEach((controller) {
        if (controller.text.isEmpty) {
          _isFormFilled = false;
        }
      });
    });
  }

  void _onSave(List<QuestionModel> questions) async {
    if (_formKey.currentState.validate()) {
      PersonalDetailsModel model = new PersonalDetailsModel(
        id: Uuid().v1(),
        name: _inputControllers[0].text.capitalize(),
        surname: _inputControllers[1].text.capitalize(),
        cellNumber: _inputControllers[2].text,
      );

      switch (this.widget.inputState) {
        case PageInputState.Insert:
          await this._addPersonalDetailsBloc.savePersonalDetails(model);

          break;
        case PageInputState.Edit:
          await this._addPersonalDetailsBloc.updatePersonalDetails(model);
          break;
        default:
      }
      Navigator.pushReplacementNamed(context, SelfDeclarationPage.route);
    }
  }
}
