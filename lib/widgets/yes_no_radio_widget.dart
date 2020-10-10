import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YesNoRadioWidget extends StatefulWidget {
  final String title;
  final Function(String) onChanged;
  final int initialValue;

  const YesNoRadioWidget(
      {Key key, this.title, this.onChanged, this.initialValue})
      : super(key: key);

  @override
  _YesNoRadioWidgetState createState() => _YesNoRadioWidgetState();
}

class _YesNoRadioWidgetState extends State<YesNoRadioWidget> {
  int _groupValue = -1;

  String _firstLabel = "Yes";
  String _secondLabel = "No";

  @override
  void initState() {
    if (this.widget.initialValue != null) {
      _groupValue = this.widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.widget.title),
          _buildYesNoRadioButtons(),
        ],
      ),
    );
  }

  Widget _buildYesNoRadioButtons() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: 0,
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value;
                });
                this.widget.onChanged(_firstLabel);
              },
            ),
            Text(_firstLabel)
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value;
                });
                this.widget.onChanged(_secondLabel);
              },
            ),
            Text(_secondLabel)
          ],
        )
      ],
    );
  }
}
