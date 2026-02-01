import 'package:color_scale/src/core/color_calculation.dart';
import 'package:color_scale/src/core/color_scale_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {
  test('getColorForValue returns correct OKLCH color for midpoint', () {
    const double minValue = -20;
    const Color minColor = Colors.red;
    const double maxValue = 20;
    const Color maxColor = Colors.green;
    const double value = 0;

    final Color actualColor = ColorCalculation.getColorForValue(
      value,
      {
        minValue: minColor,
        maxValue: maxColor,
      },
      ColorScaleTypeEnum.oklch,
    );

    final OKLCHColor minOklch = OKLCHColor.fromColor(minColor);
    final OKLCHColor maxOklch = OKLCHColor.fromColor(maxColor);
    const double t = 0.5;

    final double lightness = minOklch.lightness * (1 - t) + maxOklch.lightness * t;
    final double chroma = minOklch.chroma * (1 - t) + maxOklch.chroma * t;
    final double hue = _lerpHue(minOklch.hue, maxOklch.hue, t);

    final Color expectedColor =
        OKLCHColor(lightness, chroma, hue).toColor();

    expect(actualColor.red, expectedColor.red);
    expect(actualColor.green, expectedColor.green);
    expect(actualColor.blue, expectedColor.blue);
  });
}

double _lerpHue(double startHue, double endHue, double t) {
  double delta = (endHue - startHue) % 360;
  if (delta > 180) {
    delta -= 360;
  }
  return (startHue + delta * t) % 360;
}
