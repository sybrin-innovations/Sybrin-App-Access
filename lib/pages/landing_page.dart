import 'dart:convert';

import 'package:access/blocs/qrcode_scan_bloc.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:access/extentions/navigator_extensions.dart';
import 'package:access/models/scan_result_model.dart';

class LandingPage extends StatefulWidget {
  static const String route = "/landing";

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  QRCodeScanBloc _qrCodeScanBloc = QRCodeScanBloc();

  @override
  void initState() {
    super.initState();
  }

  Future<ScanResultModel> _scanQRCode() async {
    String resultString = await Navigator.of(context).pushQRCapture();
    return ScanResultModel.fromJson(json.decode(resultString));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Enter"),
          onPressed: onEnter,
        ),
      ),
    );
  }

  void onEnter() async {
    ScanResultModel model = await _scanQRCode();

    if (model.success) {
      _qrCodeScanBloc.setFormUrl(model.value);
      Navigator.pushNamed(context, SelfDeclarationPage.route);
    }
  }
}
