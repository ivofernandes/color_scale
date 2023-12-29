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

  const ColorScaleWidget({
      required this.value,
      this.minValue = -20,
      this.maxValue = 20,
      this.minColor = Colors.red,
      this.maxColor = Colors.green,
      this.child,
      super.key,
      });

  @override
  Widget build(BuildContext context) {
    final Color color =
        getColorForValue(value, minValue, minColor, maxValue, maxColor);

    return Container(
      color: color,
      child: child,
    );
  }

  /// Gets the color of the container
  static Color getColorForValue(double value, double minValue, Color minColor,
      double maxValue, Color maxColor) {
    if (value.isNaN || value.isInfinite) {
      return Colors.black;
    }

    final double range = maxValue - minValue;
    final double relativeValue = value - minValue;

    double percentageOfMaxColor = relativeValue / range;
    percentageOfMaxColor = min(percentageOfMaxColor, 1);
    percentageOfMaxColor = max(percentageOfMaxColor, 0);

    final double percentageOfMinColor = 1 - percentageOfMaxColor;

    final double opacity = minColor.opacity * percentageOfMinColor +
        maxColor.opacity * percentageOfMaxColor;

    final double green = minColor.green * percentageOfMinColor +
        maxColor.green * percentageOfMaxColor;
    final double blue = minColor.blue * percentageOfMinColor +
        maxColor.blue * percentageOfMaxColor;
    final double red = minColor.red * percentageOfMinColor +
        maxColor.red * percentageOfMaxColor;
    return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), opacity);
  }
}
