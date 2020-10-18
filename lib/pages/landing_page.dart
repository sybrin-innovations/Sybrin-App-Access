import 'dart:convert';

import 'package:access/blocs/qrcode_scan_bloc.dart';
import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/pages/self_declaration_page.dart';
import 'package:access/widgets/gradient_button.dart';
import 'package:access/widgets/gradient_icon.dart';
import 'package:access/widgets/sybrin_access_logo_widget.dart';
import 'package:access/widgets/sybrin_background_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:access/extentions/navigator_extensions.dart';
import 'package:access/models/scan_result_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Stack(
        children: [
          SybrinBackgroundWidget(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
        child: Column(
          children: [
            Flexible(
              flex: 8,
              child: Center(
                child: _buildLogo(),
              ),
            ),
            Flexible(
              flex: 10,
              child: Center(
                child: _buildIcon(),
              ),
            ),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SybrinAccessLogoWidget();
  }

  Widget _buildIcon() {
    return Container(
      margin: EdgeInsets.only(
        left: 40,
        right: 40,
        bottom: MediaQuery.of(context).size.height * 0.08,
      ),
      child: GradientIcon(
          icon: FontAwesomeIcons.shieldAlt,
          gradient: SybrinGradients.getLinearGradient(context)),
    );
  }

  Widget _buildButton() {
    return GradientButton(
      title: "Enter".toUpperCase(),
      onPressed: onEnter,
      gradient: SybrinGradients.getLinearGradient(context),
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
