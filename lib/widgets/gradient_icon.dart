import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientIcon extends StatefulWidget {
  final IconData icon;
  final Gradient gradient;

  GradientIcon({
    this.icon,
    this.gradient,
  });

  @override
  _GradientIconState createState() => _GradientIconState();
}

class _GradientIconState extends State<GradientIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double size = constraints.maxWidth > constraints.maxHeight
              ? constraints.maxHeight
              : constraints.maxWidth;

          return ShaderMask(
            child: SizedBox(
              width: size * 1.2,
              height: size * 1.2,
              child: Icon(
                widget.icon,
                size: size * 0.95,
                color: Colors.white,
              ),
            ),
            shaderCallback: (Rect bounds) {
              final Rect rect = Rect.fromLTRB(0, 0, size, size);
              return widget.gradient.createShader(rect);
            },
          );
        },
      ),
    );
  }
}
