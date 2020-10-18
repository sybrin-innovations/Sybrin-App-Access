import 'package:access/utils/asset_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SybrinAccessLogoWidget extends StatefulWidget {
  @override
  _SybrinAccessLogoWidgetState createState() => _SybrinAccessLogoWidgetState();
}

class _SybrinAccessLogoWidgetState extends State<SybrinAccessLogoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double widthToHeightRatio = 0.88967;
        double height = constraints.maxHeight * 0.5;
        double width = height * widthToHeightRatio;

        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AssetData.sybrinLogoSVG,
                height: height,
                alignment: Alignment.topCenter,
                color: Colors.white,
              ),
              Container(
                width: width,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: AutoSizeText(
                    "Access".toUpperCase(),
                    textAlign: TextAlign.center,
                    wrapWords: false,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
