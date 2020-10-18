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
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              this.widget.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          _buildRadioButtons(),
        ],
      ),
    );
  }

  Widget _buildRadioButtons() {
    return Column(
      children: List.generate(this.widget.selectionItems.length, (index) {
        return Container(
          child: _buildRadioItem(index),
        );
      }),
    );
  }

  Widget _buildRadioItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: _groupValue == index
            ? Theme.of(context).backgroundColor.withOpacity(0.8)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      child: RadioListTile(
        title: Text(
          this.widget.selectionItems[index],
          style: _groupValue == index
              ? Theme.of(context).textTheme.bodyText2
              : Theme.of(context).textTheme.bodyText1,
        ),
        activeColor: Theme.of(context).primaryColor,
        value: index,
        groupValue: _groupValue,
        onChanged: (value) {
          setState(() {
            _groupValue = value;
          });
          this.widget.onChanged(this.widget.selectionItems[index]);
        },
      ),
    );
  }
}
