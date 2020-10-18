import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/widgets/gradient_icon.dart';
import 'package:access/widgets/sybrin_background_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_text/gradient_text.dart';

class WelcomePage extends StatefulWidget {
  static const route = '/thanks';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            Navigator.pop(context);
          }
        },
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return Stack(
      children: [
        SybrinBackgroundWidget(),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: GradientIcon(
                    icon: FontAwesomeIcons.mapMarkerAlt,
                    gradient: SybrinGradients.getLinearGradient(context),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GradientText(
                  "Welcome to Sybrin!",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                  gradient: SybrinGradients.getLinearGradient(context),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 3,
                decoration: BoxDecoration(
                    gradient: SybrinGradients.getLinearGradient(context)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Please remember to have your temperature taken before you leave!",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                child: Container(),
              )
            ],
          ),
        )
      ],
    );
  }
}
