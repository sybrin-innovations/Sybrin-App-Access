import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final Widget leading, trailing, child;
  final double height, childHeight;
  final bool isBig;
  final String backgroundImage;

  const CustomAppBar({
    Key key,
    this.leading,
    this.trailing,
    this.height,
    this.childHeight,
    this.isBig,
    this.child,
    this.backgroundImage,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: _AppBarClipper(
              childHeight: widget.childHeight, isBig: widget.isBig),
          child: Container(
            color: Theme.of(context).backgroundColor,
            height: widget.height,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(this.widget.backgroundImage),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter),
                      ),
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      widget.leading,
                      Text(" "),
                      widget.trailing
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: widget.childHeight / 2,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}

class _AppBarClipper extends CustomClipper<Path> {
  final bool isBig;
  final double childHeight;

  _AppBarClipper({@required this.isBig, @required this.childHeight});

  @override
  Path getClip(Size size) {
    double height = isBig ? size.height - childHeight : size.height;
    Path path = Path();

    path.moveTo(0, height - 40);
    path.quadraticBezierTo(size.width / 2, height, size.width, height - 40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
