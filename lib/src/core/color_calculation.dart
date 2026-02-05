import 'package:color_scale/src/core/color_scale_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:hsluv/hsluvcolor.dart';
import 'package:oklch/oklch.dart';

class ColorCalculation {
  static Color getColorForValue(double value, Map<double, Color> colorStops,
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
    switch (colorScaleTypeEnum) {
      case ColorScaleTypeEnum.rgb:
        return _getColorForValueRGB(
            prevColor, nextColor, percentageOfPrevColor, percentageOfNextColor);
      case ColorScaleTypeEnum.hsluv:
        return _getColorForValueHsluv(
            prevColor, nextColor, percentageOfPrevColor, percentageOfNextColor);
      case ColorScaleTypeEnum.oklch:
        return _getColorForValueOklch(
            prevColor, nextColor, percentageOfPrevColor, percentageOfNextColor);
    }
  }

  static Color _getColorForValueRGB(Color prevColor, Color nextColor,
      double percentageOfPrevColor, double percentageOfNextColor) {
    // Mix the colors based on the percentage
    final double green =
        _toColorInt(prevColor.g) * percentageOfPrevColor +
            _toColorInt(nextColor.g) * percentageOfNextColor;
    final double blue = _toColorInt(prevColor.b) * percentageOfPrevColor +
        _toColorInt(nextColor.b) * percentageOfNextColor;
    final double red = _toColorInt(prevColor.r) * percentageOfPrevColor +
        _toColorInt(nextColor.r) * percentageOfNextColor;
    final double opacity =
        prevColor.a * percentageOfPrevColor + nextColor.a * percentageOfNextColor;
    return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), opacity);
  }

  static Color _getColorForValueHsluv(Color prevColor, Color nextColor,
      double percentageOfPrevColor, double percentageOfNextColor) {
    // Alpha is calculated independently
    final double alpha = prevColor.a * percentageOfPrevColor +
        nextColor.a * percentageOfNextColor;

    // RGB is calculated by using the HSLuvColor class
    final HSLuvColor prevHsluvColor = HSLuvColor.fromColor(prevColor);
    final HSLuvColor nextHsluvColor = HSLuvColor.fromColor(nextColor);

    final double lightness = prevHsluvColor.lightness * percentageOfPrevColor +
        nextHsluvColor.lightness * percentageOfNextColor;

    final double saturation =
        prevHsluvColor.saturation * percentageOfPrevColor +
            nextHsluvColor.saturation * percentageOfNextColor;

    final double hue = prevHsluvColor.hue * percentageOfPrevColor +
        nextHsluvColor.hue * percentageOfNextColor;

    final Color color =
        HSLuvColor.fromHSL(hue, saturation, lightness).toColor();
    return color.withValues(alpha: alpha);
  }

  static Color _getColorForValueOklch(Color prevColor, Color nextColor,
      double percentageOfPrevColor, double percentageOfNextColor) {
    final double alpha = prevColor.a * percentageOfPrevColor +
        nextColor.a * percentageOfNextColor;

    final OKLCHColor prevOklch = OKLCHColor.fromColor(prevColor);
    final OKLCHColor nextOklch = OKLCHColor.fromColor(nextColor);

    final double lightness =
        prevOklch.lightness * percentageOfPrevColor +
            nextOklch.lightness * percentageOfNextColor;

    final double chroma =
        prevOklch.chroma * percentageOfPrevColor +
            nextOklch.chroma * percentageOfNextColor;

    final double hue =
        _lerpHue(prevOklch.hue, nextOklch.hue, percentageOfNextColor);

    final Color color = OKLCHColor(lightness, chroma, hue).toColor();
    return color.withValues(alpha: alpha);
  }

  static int _toColorInt(double colorComponent) =>
      (colorComponent * 255.0).round() & 0xff;

  static double _lerpHue(double startHue, double endHue, double t) {
    double delta = (endHue - startHue) % 360;
    if (delta > 180) {
      delta -= 360;
    }
    return (startHue + delta * t) % 360;
  }
}
