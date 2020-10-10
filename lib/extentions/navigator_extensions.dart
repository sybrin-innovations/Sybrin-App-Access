import 'package:access/handlers/channel_handler.dart';
import 'package:flutter/material.dart';

extension NavigatorExtension on NavigatorState {
  Future<String> pushQRCapture() async {
    ChannelHandler _channelHandler = ChannelHandler();
    return await _channelHandler.captureQRCode();
  }
}
