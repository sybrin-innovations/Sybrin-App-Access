import 'package:access/pages/self_declaration_page.dart';
import 'package:access/widgets/iconized_text_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:access/extentions/string_validation_extensions.dart';

class RegistrationPage extends StatefulWidget {
  static const route = '/';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isFormFilled = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _surnameNode = FocusNode();
  final FocusNode _numberNode = FocusNode();

  int _cellNumberLength = 10;

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
                      onChanged:(_) => isFormEmpty(),
                    ),
                    IconizedTextInputWidget(
                      controller: _surnameController,
                      formKey: _formKey,
                      hint: "Surname",
                      textInputType: TextInputType.text,
                      validator: _validateName,
                      focusNode: _surnameNode,
                      nextFocusNode: _numberNode,
                      onChanged:(_) => isFormEmpty(),
                    ),
                    IconizedTextInputWidget(
                      controller: _numberController,
                      formKey: _formKey,
                      hint: "Cell Number",
                      maxLength: _cellNumberLength,
                      textInputType: TextInputType.number,
                      validator: _validateCellNumber,
                      focusNode: _numberNode,
                      onChanged:(_) => isFormEmpty(),
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
      }else{
        _isFormFilled = true;
      }
    });
  }

  void _onSave() {
    if (_formKey.currentState.validate()) {
      Navigator.pushReplacementNamed(context, SelfDeclarationPage.route);
    }
  }
}
