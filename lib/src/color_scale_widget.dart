import 'dart:math';

import 'package:flutter/material.dart';

/// This widget is a container that have a background color that depends on a value
class ColorScaleWidget extends StatelessWidget {
  /// Value taken in consideration to choose the color
  final double value;

  /// Min vale for the the value ranges
  final double minValue;

  /// Color if the value passed is the minValue
  final Color minColor;

  /// Max value for the value ranges
  final double maxValue;

  /// Color if the value passed is the maxValue
  final Color maxColor;

  /// Widget that will be rendered inside the container
  final Widget? child;

  const ColorScaleWidget(
      {required this.value,
      this.minValue = -20,
      this.maxValue = 20,
      this.minColor = Colors.red,
      this.maxColor = Colors.green,
      this.child,
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

    double range = maxValue - minValue;
    double relativeValue = value - minValue;

    double percentageOfMaxColor = relativeValue / range;
    percentageOfMaxColor = min(percentageOfMaxColor, 1);
    percentageOfMaxColor = max(percentageOfMaxColor, 0);

    double percentageOfMinColor = 1 - percentageOfMaxColor;

    double green = minColor.green * percentageOfMinColor +
        maxColor.green * percentageOfMaxColor;
    double blue = minColor.blue * percentageOfMinColor +
        maxColor.blue * percentageOfMaxColor;
    double red = minColor.red * percentageOfMinColor +
        maxColor.red * percentageOfMaxColor;
    return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), 1);
  }
}
