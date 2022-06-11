import 'dart:math';

import 'package:flutter/material.dart';

class ColorScaleWidget extends StatelessWidget {
  final double value;

  final double minValue;
  final double maxValue;

  final Color minColor;
  final Color maxColor;

  final Widget child;

  const ColorScaleWidget(
      {required this.value,
      this.minValue = -20,
      this.maxValue = 20,
      this.minColor = Colors.red,
      this.maxColor = Colors.green,
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

  /// Gets the color of the container
  Color getColorForValue(double value) {
    if (value.isNaN || value.isInfinite) {
      return Colors.black;
    }

    double percentageOfMaxColor = value / maxValue;
    percentageOfMaxColor = min(percentageOfMaxColor, 1);
    percentageOfMaxColor = max(percentageOfMaxColor, 0);

    double percentageOfMinColor = value / minValue;
    percentageOfMinColor = min(percentageOfMinColor, 1);
    percentageOfMinColor = max(percentageOfMinColor, 0);

    double green = minColor.green * percentageOfMinColor +
        maxColor.green * percentageOfMaxColor;
    double blue = minColor.blue * percentageOfMinColor +
        maxColor.blue * percentageOfMaxColor;
    double red = minColor.red * percentageOfMinColor +
        maxColor.red * percentageOfMaxColor;
    return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), 1);
  }
}
