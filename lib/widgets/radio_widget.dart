import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioWidget extends StatefulWidget {
  final String title;
  final Function(String) onChanged;
  final int initialValue;
  final List<String> selectionItems;

  const RadioWidget(
      {Key key,
      this.title,
      this.onChanged,
      this.initialValue,
      this.selectionItems})
      : super(key: key);

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  int _groupValue = -1;

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
          _buildRadioButtons(),
        ],
      ),
    );
  }

  Widget _buildRadioButtons() {
    return Column(
      children: List.generate(this.widget.selectionItems.length, (index) {
        return Row(
          children: <Widget>[
            Radio(
              value: index,
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value;
                });
                this.widget.onChanged(this.widget.selectionItems[index]);
              },
            ),
            Text(this.widget.selectionItems[index])
          ],
        );
      }),
    );
  }
}
