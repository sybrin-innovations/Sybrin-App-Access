import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/widgets/gradient_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_text/gradient_text.dart';

class DrawerScaffold extends StatefulWidget {
  final String title;
  final Widget drawer;
  final Widget body;

  const DrawerScaffold({Key key, this.title, this.drawer, this.body})
      : super(key: key);
  @override
  _DrawerScaffoldState createState() => _DrawerScaffoldState();
}

class _DrawerScaffoldState extends State<DrawerScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.8),
        leading: Container(
          padding: EdgeInsets.only(left: 10),
          child: IconButton(
            icon: GradientIcon(
              icon: FontAwesomeIcons.bars,
              gradient: SybrinGradients.getLinearGradient(context),
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        title: GradientText(
          this.widget.title,
          style: Theme.of(context).textTheme.headline1,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ]),
        ),
      ),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
      drawer: this.widget.drawer,
      body: this.widget.body,
    );
  }
}
