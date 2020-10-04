import 'package:access/blocs/add_personal_details_bloc.dart';
import 'package:access/enums/page_input_state.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/widgets/iconized_text_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:access/extentions/string_validation_extensions.dart';
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

  AddPersonalDetailsBloc _addPersonalDetailsBloc = AddPersonalDetailsBloc();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _surnameNode = FocusNode();
  final FocusNode _numberNode = FocusNode();

  int _cellNumberLength = 10;

  @override
  void initState() {
    switch (this.widget.inputState) {
      case PageInputState.Edit:
        initTextFields();
        break;
      default:
    }
    super.initState();
  }

  void initTextFields() async {
    PersonalDetailsModel model =
        await this._addPersonalDetailsBloc.getPersonalDetails();
    _nameController.text = model.name;
    _surnameController.text = model.surname;
    _numberController.text = model.cellNumber;
    this._isFormFilled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    IconizedTextInputWidget(
                      controller: _nameController,
                      formKey: _formKey,
                      hint: "Name",
                      textInputType: TextInputType.text,
                      validator: _validateName,
                      focusNode: _nameNode,
                      nextFocusNode: _surnameNode,
                      onChanged: (_) => isFormEmpty(),
                    ),
                    IconizedTextInputWidget(
                      controller: _surnameController,
                      formKey: _formKey,
                      hint: "Surname",
                      textInputType: TextInputType.text,
                      validator: _validateName,
                      focusNode: _surnameNode,
                      nextFocusNode: _numberNode,
                      onChanged: (_) => isFormEmpty(),
                    ),
                    IconizedTextInputWidget(
                      controller: _numberController,
                      formKey: _formKey,
                      hint: "Cell Number",
                      maxLength: _cellNumberLength,
                      textInputType: TextInputType.number,
                      validator: _validateCellNumber,
                      focusNode: _numberNode,
                      onChanged: (_) => isFormEmpty(),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 15,
              ),
              RaisedButton(
                onPressed: _isFormFilled ? _onSave : null,
                child: Text("SAVE"),
              )
            ],
          ),
        ),
      ),
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
      if (_nameController.text.isEmpty ||
          _surnameController.text.isEmpty ||
          _numberController.text.isEmpty) {
        _isFormFilled = false;
      } else {
        _isFormFilled = true;
      }
    });
  }

  void _onSave() async {
    if (_formKey.currentState.validate()) {
      PersonalDetailsModel model = new PersonalDetailsModel(
        id: Uuid().v1(),
        name: _nameController.text,
        surname: _surnameController.text,
        cellNumber: _numberController.text,
      );

      switch (this.widget.inputState) {
        case PageInputState.Insert:
          await this._addPersonalDetailsBloc.registerUser(model);

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
