import 'package:color_scale/src/core/color_calculation.dart';
import 'package:color_scale/src/core/color_scale_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getColorForValue returns correct color for value', () {
    const double minValue = -20;
    const Color minColor = Colors.red;
    const double maxValue = 20;
    const Color maxColor = Colors.green;
    const double value = 0;

    const Color expectedColor = Color(0xffa38f3d);
    final Color actualColor = ColorCalculation.getColorForValue(
      value,
      {
        minValue: minColor,
        maxValue: maxColor,
      },
      ColorScaleTypeEnum.hsluv,
    );

    assert(actualColor.blue == expectedColor.blue);
    assert(actualColor.red == expectedColor.red);
    assert(actualColor.green == expectedColor.green);
  });
}
