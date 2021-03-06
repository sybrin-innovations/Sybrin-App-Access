import 'package:access/tweens/delay_tween.dart';
import 'package:flutter/material.dart';

enum BarWaveLoaderType { start, end, center }

class BarWaveLoader extends StatefulWidget {
  final Color color;
  final double size;
  final BarWaveLoaderType type;

  const BarWaveLoader({
    Key key,
    @required this.color,
    this.type = BarWaveLoaderType.start,
    this.size = 50.0,
  }) : super(key: key);

  @override
  _BarWaveLoaderState createState() => new _BarWaveLoaderState();
}

class _BarWaveLoaderState extends State<BarWaveLoader>
    with SingleTickerProviderStateMixin {
  AnimationController _scaleCtrl;
  final _duration = const Duration(milliseconds: 1200);

  @override
  void initState() {
    super.initState();
    _scaleCtrl = new AnimationController(
      vsync: this,
      duration: _duration,
    )..repeat();
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _bars;
    if (widget.type == BarWaveLoaderType.start) {
      _bars = [
        _bar(-1.2),
        _bar(-1.1),
        _bar(-1.0),
        _bar(-.9),
        _bar(-.8),
      ];
    } else if (widget.type == BarWaveLoaderType.end) {
      _bars = [
        _bar(-.8),
        _bar(-.9),
        _bar(-1.0),
        _bar(-1.1),
        _bar(-1.2),
      ];
    } else if (widget.type == BarWaveLoaderType.center) {
      _bars = [
        _bar(-0.75),
        _bar(-0.95),
        _bar(-1.2),
        _bar(-0.95),
        _bar(-0.75),
      ];
    }
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 1.25, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _bars,
        ),
      ),
    );
  }

  Widget _bar(double delay) {
    final _size = widget.size * 0.2;
    return new ScaleYWidget(
      scaleY:
          new DelayTween(begin: .4, end: 1.0, delay: delay).animate(_scaleCtrl),
      child: new Container(
        height: widget.size,
        width: _size,
        decoration: new BoxDecoration(
          color: widget.color,
        ),
      ),
    );
  }
}

class ScaleYWidget extends AnimatedWidget {
  final Widget child;
  final Alignment alignment;

  const ScaleYWidget({
    Key key,
    @required Animation<double> scaleY,
    @required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key, listenable: scaleY);

  Animation<double> get scaleY => listenable;

  @override
  Widget build(BuildContext context) {
    final double scaleValue = scaleY.value;
    final Matrix4 transform = new Matrix4.identity()
      ..scale(1.0, scaleValue, 1.0);
    return new Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
