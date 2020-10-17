import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckboxListWidget extends StatefulWidget {
  final String title;
  final List<String> selectionItems;
  final Function(List<String>) onChanged;
  final String cancelationValue;

  const CheckboxListWidget(
      {Key key, this.title, this.selectionItems, this.onChanged, this.cancelationValue})
      : super(key: key);

  @override
  _CheckboxListWidgetState createState() => _CheckboxListWidgetState();
}

class _CheckboxListWidgetState extends State<CheckboxListWidget> {
  Map<String, bool> _answers = Map();
  List<String> selectedItems = List<String>();
  bool _initAnswers = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.widget.title),
          _buildCheckList(),
        ],
      ),
    );
  }

  void initAnswers(){
if (_initAnswers) {
      this.widget.selectionItems.forEach((item) {
        _answers[item] = false;
      });
      _initAnswers = false;
    }
  }

  Widget _buildCheckList() {
    initAnswers();

    return Column(
      children: List.generate(
        this.widget.selectionItems.length,
        (index) {
          return CheckboxListTile(
              title: Text(this.widget.selectionItems[index]),
              value: this._answers.values.toList()[index],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  if (this.widget.selectionItems[index] == this.widget.cancelationValue && !_answers[this.widget.cancelationValue]) {
                    _initAnswers = true;
                    initAnswers();
                  }

                  if (_answers[this.widget.cancelationValue] && this.widget.selectionItems[index] != this.widget.cancelationValue) {
                    _answers[this.widget.cancelationValue] = false;
                  }

                  _answers[this.widget.selectionItems[index]] = value;
                });

                List<String> _checkedAnswers = List<String>();

                for (var i = 0; i < _answers.length; i++) {
                  if (_answers.values.toList()[i]) {
                    _checkedAnswers.add(_answers.keys.toList()[i]);
                  }
                }

                this.widget.onChanged(_checkedAnswers);
              });
        },
      ),
    );
  }
}
