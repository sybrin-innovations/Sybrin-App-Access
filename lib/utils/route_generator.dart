import 'package:access/enums/page_input_state.dart';
import 'package:access/models/error_arguments_model.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/error_page.dart';
import 'package:access/pages/go_home_page.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/pages/symptoms_page.dart';
import 'package:access/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case SelfDeclarationPage.route:
        return PageTransition(
            child: SelfDeclarationPage(), type: PageTransitionType.rightToLeft);
        break;
      case SymptomsPage.route:
        return PageTransition(
            child: SymptomsPage(), type: PageTransitionType.rightToLeft);
        break;
      case WelcomePage.route:
        return PageTransition(
            child: WelcomePage(), type: PageTransitionType.rightToLeft);
        break;
      case GoHomePage.route:
        return PageTransition(
            child: GoHomePage(), type: PageTransitionType.rightToLeft);
        break;
      case AddPersonalDetailsPage.route:
        if (args == null) {
          return PageTransition(
              child: AddPersonalDetailsPage(),
              type: PageTransitionType.rightToLeft);
        }
        if (args is PageInputState) {
          return PageTransition(
              child: AddPersonalDetailsPage(
                inputState: args,
              ),
              type: PageTransitionType.rightToLeft);
        }

        return _routeError(settings.name);
        break;
      case ErrorPage.route:
        if (args is ErrorArgumentsModel) {
          return MaterialPageRoute(
            builder: (_) => ErrorPage(
              errorArguments: args,
            ),
          );
        }

        return _routeError(settings.name);
        break;
      default:
        return _routeError(settings.name);
    }
  }

  static Route<dynamic> _routeError(String routeName) {
    String _errorMessage = "There was an error when navigating to a new page.";
    return MaterialPageRoute(
      builder: (context) => ErrorPage(
        errorArguments: ErrorArgumentsModel(errorMessage: _errorMessage),
      ),
    );
  }
}
