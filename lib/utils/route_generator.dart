import 'package:access/enums/page_input_state.dart';
import 'package:access/models/error_arguments_model.dart';
import 'package:access/pages/add_personal_details_page.dart';
import 'package:access/pages/error_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AddPersonalDetailsPage.route:
        if (args == null) {
          return MaterialPageRoute(builder: (_) => AddPersonalDetailsPage());
        }
        if (args is PageInputState) {
          return MaterialPageRoute(
            builder: (_) => AddPersonalDetailsPage(
              inputState: args,
            ),
          );
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
