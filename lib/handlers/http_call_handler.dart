import 'dart:io';

import 'package:access/models/data_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:access/enums/alert_type.dart';
import 'package:access/widgets/alert_popup.dart';

class HttpCallHandler {
  static Future<DataResult<String>> makeJsonCall(String json, String url, {String errorMessage}) async {
    DataResult<String> result;
    try {
      Response response = await post(url, headers: {"Content-Type": "application/json"}, body: json);
      if (response.statusCode == 201) {
        result = DataResult<String>(success: true, value: response.body);
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      debugPrint('HTTP ERROR : $e');
      result =
          DataResult<String>(success: false, error: errorMessage != null ? errorMessage : "Error making http call");
    }

    return result;
  }

  static Future<bool> internetConnAvailable(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException catch (_) {
      await HttpCallHandler()._noInternetConnectionModal(context);
      return Future.value(false);
    }

    // If we make it to this part it's safe to assume we don't have internet access
    HttpCallHandler()._noInternetConnectionModal(context);
    return Future.value(false);
  }

  Future<void> _noInternetConnectionModal(BuildContext context) async {
    // There was no internet connection. Showing modal to user before we continue.
    await AlertPopup.showAlert(
      context: context,
      alertType: AlertType.Error,
      text: "No Internet Connection\nPlease check your connection.",
      buttonText: "OK",
    );
  }
}
