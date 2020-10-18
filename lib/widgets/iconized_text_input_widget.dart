import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconizedTextInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final GlobalKey<FormState> formKey;
  final Function(String) validator;
  final Function(String) onChanged;
  final TextInputType textInputType;
  final IconData prefixIcon;
  final String initialValue;
  final int maxLength;
  final Function onEditingComplete;
  final Widget suffixIcon;
  final bool readOnly;
  final Function onTap;

  IconizedTextInputWidget(
      {@required this.controller,
      @required this.hint,
      this.focusNode,
      @required this.formKey,
      this.nextFocusNode,
      this.validator,
      this.textInputType,
      this.prefixIcon,
      this.initialValue,
      this.maxLength,
      this.onEditingComplete,
      this.onChanged,
      this.suffixIcon,
      this.readOnly = false,
      this.onTap});

  @override
  _IconizedTextInputWidgetState createState() =>
      _IconizedTextInputWidgetState();
}

class _IconizedTextInputWidgetState extends State<IconizedTextInputWidget> {
  String _labelText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: this.widget.onTap,
      readOnly: this.widget.readOnly,
      autofocus: false,
      initialValue: this.widget.initialValue,
      maxLength: this.widget.maxLength,
      autocorrect: false,
      controller: this.widget.controller,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        suffixIcon:
            this.widget.suffixIcon == null ? null : this.widget.suffixIcon,
        prefixIcon: this.widget.prefixIcon == null
            ? null
            : Icon(this.widget.prefixIcon),
        border: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).accentColor, width: 0.0),
        ),
        labelText:
            this.widget.controller != null && this.widget.controller.text != "" ? this.widget.hint : _labelText,
        labelStyle: Theme.of(context)
            .textTheme
            .headline3,
        hintText: widget.hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1.apply(color: Colors.grey[700]),
      ),
      focusNode: widget.focusNode,
      keyboardType: this.widget.textInputType,
      onEditingComplete: () {
        if (this.widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(this.widget.nextFocusNode);
        }

        if (this.widget.onEditingComplete != null) {
          this.widget.onEditingComplete();
        }
      },
      onChanged: (text) {
        setState(() {
          if (text.isNotEmpty) {
            _labelText = this.widget.hint;
          } else {
            _labelText = null;
          }
        });
        this.widget.onChanged(text);
      },
      validator: this.widget.validator != null
          ? (value) {
              return this.widget.validator(value);
            }
          : null,
    );
  }
}
