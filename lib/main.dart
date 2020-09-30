import 'package:access/pages/registration_page.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/pages/symptoms_page.dart';
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
      initialRoute: RegistrationPage.route,
      routes: {
        RegistrationPage.route: (BuildContext context) => RegistrationPage(),
        SelfDeclarationPage.route: (BuildContext context) => SelfDeclarationPage(),
        SymptomsPage.route: (BuildContext context) => SymptomsPage()
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => RegistrationPage(),
        );
      },
    );
  }
}


