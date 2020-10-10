import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class ChannelHandler {
  static const String _CHANNEL = 'com.sybrin.access';
  static const platform = MethodChannel(_CHANNEL);

  Future<String> captureQRCode() async {
    String data = "";
    try {
      // Executing Channel to native android and iOS SDK
      data = await platform
          .invokeMethod('scanQRCode');

      // Checking to see if we received data from the SDK
      if (data == null || data.length <= 0 || data.isEmpty) {
        return null;
      }
    } catch (e) {
      debugPrint("HANDLER ERROR : $e");
      return null;
    }

    return data;
  }
}
