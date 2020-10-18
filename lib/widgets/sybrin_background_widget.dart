import 'package:access/utils/asset_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SybrinBackgroundWidget extends StatelessWidget {
  final bool withColor;

  const SybrinBackgroundWidget({Key key, this.withColor = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        AssetData.sybrinBackgroundImage,
        fit: BoxFit.cover,
        color: this.withColor ? Theme.of(context).backgroundColor.withOpacity(0.85) : null,
        colorBlendMode: this.withColor ? BlendMode.multiply : null,
      ),
    );
  }
}
