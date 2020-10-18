import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:access/utils/asset_data.dart';
import 'package:access/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_text/gradient_text.dart';

class PersonalDetailsAppBar extends StatefulWidget {
  final PersonalDetailsModel personalDetails;
  final Function onEditPressed;
  final double height;

  const PersonalDetailsAppBar(
      {Key key, this.personalDetails, this.onEditPressed, this.height = 220})
      : super(key: key);
  @override
  _PersonalDetailsAppBarState createState() => _PersonalDetailsAppBarState();
}

class _PersonalDetailsAppBarState extends State<PersonalDetailsAppBar> {
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      backgroundImage: AssetData.aiFaceImage,
      child: Hero(
        tag: "persona-details-tag",
        child: _buildPersonalDetailsIcon()),
      leading: Container(),
      trailing: Container(),
      isBig: true,
      childHeight: 50,
      height: this.widget.height,
    );
  }

  String getFirstLetter() {
    try {
      return this.widget.personalDetails.name.substring(0, 1).toUpperCase();
    } catch (e) {
      return "";
    }
  }

  String getSecondLetter() {
    try {
      return this.widget.personalDetails.surname.substring(0, 1).toUpperCase();
    } catch (e) {
      return "";
    }
  }

  Widget _buildPersonalDetailsIcon() {
    String displayName = getFirstLetter() + getSecondLetter();

    if (displayName.length == 0) {
      displayName = "S";
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipOval(
          child: Container(
            color: Theme.of(context).canvasColor,
            height: 100,
            width: 100,
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).backgroundColor.withOpacity(0.8),
                      width: 4)),
              child: Center(
                child: GradientText(
                  this.widget.personalDetails == null ? "S" : displayName,
                  gradient: SybrinGradients.getLinearGradient(context),
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ),
        ),
        this.widget.onEditPressed == null
            ? Container()
            : Container(
                width: 100,
                height: 100,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: _buildEditButton(),
                ),
              )
      ],
    );
  }

  _buildEditButton() {
    return GestureDetector(
      onTap: this.widget.onEditPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: SybrinGradients.getLinearGradient(context),
          shape: BoxShape.circle,
          border: Border.all(
              color: Theme.of(context).backgroundColor.withOpacity(0.8),
              width: 2),
        ),
        child: Icon(
          FontAwesomeIcons.penAlt,
          size: 17,
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }
}
