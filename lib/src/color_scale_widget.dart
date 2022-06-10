import 'package:flutter/material.dart';

class ColorScaleWidget extends StatelessWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final Widget child;

  const ColorScaleWidget(
      {required this.value,
      this.minValue = -20,
      this.maxValue = 20,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = getColorForValue(value);

    return Container(
      color: color,
      child: child,
    );
  }

  Color getColorForValue(double value) {
    if (value.isNaN || value.isInfinite) {
      return Colors.black;
    }

    if (value > 0) {
      double green = 255 * value / maxValue;
      double blue = (255 - green) / 8;
      double red = (255 - green) / 8;
      return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), 1);
    } else {
      double red = 255 * value / (minValue * -1);
      double blue = (255 - red) / 8;
      double green = (255 - red) / 8;
      return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), 1);
    }
  }
}
