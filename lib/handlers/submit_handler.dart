import 'dart:convert';

import 'package:access/models/data_result.dart';
import 'package:access/models/form_model.dart';
import 'package:flutter/cupertino.dart';

import 'http_call_handler.dart';

class SubmitHandler{
  
  Future<DataResult<String>> submitData(FormModel model) async {
    DataResult<String> dataResult;
    try {
      String value = json.encode(json.encode(model.toJson()));

      DataResult<String> httpResult =
          await HttpCallHandler.makeJsonCall(value, model.url);
      if (httpResult.success) {
        dataResult = DataResult<String>(success: true, value: httpResult.value);
      } else {
        throw Exception(httpResult.error);
      }
    } catch (e) {
      debugPrint('PROVIDER ERROR : $e');
      dataResult =
          DataResult<String>(success: false, error: "Error getting response");
    }

    return dataResult;
  }
}