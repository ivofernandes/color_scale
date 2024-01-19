import 'package:color_scale/src/core/color_scale_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:hsluv/hsluvcolor.dart';

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
    for (final double stop in colorStops.keys) {
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

    // If is between needs to be calculated
    if (colorScaleTypeEnum == ColorScaleTypeEnum.rgb) {
      return _getColorForValueRGB(prevColor, nextColor, percentageOfPrevColor, percentageOfNextColor);
    } else if (colorScaleTypeEnum == ColorScaleTypeEnum.hsluv) {
      return _getColorForValueOKLCH(prevColor, nextColor, percentageOfPrevColor, percentageOfNextColor);
    } else {
      throw Exception('Color scale type not supported');
    }
  }

  static Color _getColorForValueRGB(Color prevColor, Color nextColor, double percentageOfPrevColor, double percentageOfNextColor) {
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

  static Color _getColorForValueOKLCH(Color prevColor, Color nextColor, double percentageOfPrevColor, double percentageOfNextColor) {
    // Alpha is calculated independently
    final double alpha = prevColor.opacity * percentageOfPrevColor +
        nextColor.opacity * percentageOfNextColor;


    // RGB is calculated by using the HSLuvColor class
    final HSLuvColor prevHsluvColor = HSLuvColor.fromColor(prevColor);
    final HSLuvColor nextHsluvColor = HSLuvColor.fromColor(nextColor);

    final double lightness = prevHsluvColor.lightness * percentageOfPrevColor +
        nextHsluvColor.lightness * percentageOfNextColor;

    final double saturation = prevHsluvColor.saturation * percentageOfPrevColor +
        nextHsluvColor.saturation * percentageOfNextColor;

    final double hue = prevHsluvColor.hue * percentageOfPrevColor +
        nextHsluvColor.hue * percentageOfNextColor;


    final Color color = HSLuvColor.fromHSL(hue, saturation, lightness).toColor();
    return color.withOpacity(alpha);
  }

}
