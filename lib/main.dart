import 'package:access/pages/landing_page.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/themes/sybrin_theme.dart';
import 'package:access/utils/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Sybrin Access',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: SybrinTheme.aiTheme,
      initialRoute: LandingPage.route,
      routes: {
        LandingPage.route: (BuildContext context) => LandingPage(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => SelfDeclarationPage(),
        );
      },
    );
  }
}
