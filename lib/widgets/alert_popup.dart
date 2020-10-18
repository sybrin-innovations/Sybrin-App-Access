import 'package:access/enums/alert_type.dart';
import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/widgets/gradient_button.dart';
import 'package:access/widgets/pill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertPopup extends StatefulWidget {
  final AlertType alertType;
  final String text;
  final String buttonText;

  AlertPopup({
    @required this.alertType,
    @required this.text,
    @required this.buttonText,
  });

  @override
  _AlertPopupState createState() => _AlertPopupState();

  static Future<bool> showAlert({
    BuildContext context,
    @required AlertType alertType,
    @required String text,
    @required String buttonText,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertPopup(
            alertType: alertType,
            text: text,
            buttonText: buttonText,
          );
        });
  }
}

class _AlertPopupState extends State<AlertPopup>
    with SingleTickerProviderStateMixin {
  final double _standardIconSize = 50;
  AnimationController _animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    this._animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    this._scaleAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.elasticInOut);

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: _buildDialogueBox(),
      ),
    );
  }

  Widget _buildDialogueBox() {
    return Dialog(
      child: Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildIcon(),
            SizedBox(
              height: 10,
            ),
            _buildText(),
            SizedBox(
              height: 30,
            ),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    switch (this.widget.alertType) {
      case AlertType.Info:
        return Icon(
          Icons.info_outline,
          color: Theme.of(context).colorScheme.background,
          size: this._standardIconSize,
        );
        break;
      case AlertType.Error:
        return Icon(
          Icons.error_outline,
          color: Theme.of(context).errorColor,
          size: this._standardIconSize,
        );
        break;
      default:
        return Container();
    }
  }

  Widget _buildText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        this.widget.text,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      child: Column(
        children: <Widget>[
          GradientButton(
            title: this.widget.buttonText.toUpperCase(),
            onPressed: _onButtonPressed,
            gradient: SybrinGradients.getLinearGradient(context),
          ),
          this.widget.alertType != AlertType.Error
              ? SizedBox(
                  height: 10,
                )
              : Container(),
          this.widget.alertType != AlertType.Error
              ? Container(
                  height: 50,
                  child: PillButton(
                    buttonTextStyle: Theme.of(context)
                        .textTheme
                        .button
                        .apply(color: Colors.black),
                    backgroundColor: Theme.of(context).cardColor,
                    buttonText: "Cancel".toUpperCase(),
                    onPressed: _onBackPressed,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _onButtonPressed() {
    Navigator.pop(context, true);
  }

  void _onBackPressed() {
    Navigator.pop(context, false);
  }
}
