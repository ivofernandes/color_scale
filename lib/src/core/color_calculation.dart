import 'package:color_scale/src/core/color_scale_type_enum.dart';
import 'package:flutter/material.dart';

class ColorCalculation {
  static Color getColorForValue(
      double value,
      Map<double, Color>  colorStops,
      ColorScaleTypeEnum colorScaleTypeEnum) {
    // Check if the value is lower than the lowest stop
    if (value < colorStops.keys.first) {
      return colorStops.values.first;
    }
    // Check if the value is higher than the highest stop
    if (value > colorStops.keys.last) {
      return colorStops.values.last;
    }
    // Find the two closest stops
    double prevStop = 0;
    double nextStop = 0;
    Color prevColor = Colors.black;
    Color nextColor = Colors.black;
    for (var stop in colorStops.keys) {
      if (stop <= value) {
        prevStop = stop;
        prevColor = colorStops[stop]!;
      } else {
        nextStop = stop;
        nextColor = colorStops[stop]!;
        break;
      }
    }
    // Calculate the percentage of each color based on the value
    final double range = nextStop - prevStop;
    final double relativeValue = value - prevStop;
    double percentageOfNextColor = relativeValue / range;
    percentageOfNextColor = percentageOfNextColor.clamp(0, 1);
    final double percentageOfPrevColor = 1 - percentageOfNextColor;
    // Mix the colors based on the percentage
    final double green = prevColor.green * percentageOfPrevColor +
        nextColor.green * percentageOfNextColor;
    final double blue = prevColor.blue * percentageOfPrevColor +
        nextColor.blue * percentageOfNextColor;
    final double red = prevColor.red * percentageOfPrevColor +
        nextColor.red * percentageOfNextColor;
    final double opacity = prevColor.opacity * percentageOfPrevColor +
        nextColor.opacity * percentageOfNextColor;
    return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), opacity);

  }
}
