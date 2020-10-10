
import 'package:access/pages/landing_page.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/pages/symptoms_page.dart';
import 'package:access/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Sybrin Access',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(primaryColor: Colors.blue, accentColor: Colors.lightBlue, backgroundColor: Colors.deepPurple),
      initialRoute: LandingPage.route,
      routes: {
        LandingPage.route: (BuildContext context) => LandingPage(),
        SelfDeclarationPage.route: (BuildContext context) => SelfDeclarationPage(),
        SymptomsPage.route: (BuildContext context) => SymptomsPage()
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => SelfDeclarationPage(),
        );
      },
    );
  }
}


