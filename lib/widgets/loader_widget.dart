import 'package:access/gradients/sybrin_gradients.dart';
import 'package:access/widgets/bar_wave_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatefulWidget {
  final String text;

  const LoaderWidget({Key key, this.text = ""}) : super(key: key);

  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration:
            BoxDecoration(gradient: SybrinGradients.getLinearGradient(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: BarWaveLoader(color: Colors.white, size: 60)),
            Text(
              this.widget.text,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
