import 'package:color_scale/src/color_scale_widget.dart';
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

    final Color expectedColor = Color.lerp(Colors.red, Colors.green, 0.5)!;
    final actualColor = ColorCalculation.getColorForValue(
        value, {minValue: minColor, maxValue: maxColor,},
      ColorScaleTypeEnum.rgb,
    );

    assert(actualColor.blue == expectedColor.blue);
    assert(actualColor.red == expectedColor.red);
    assert(actualColor.green == expectedColor.green);
  });

  testWidgets('ColorScaleWidget renders correct color', (tester) async {
    const minValue = -20.0;
    const minColor = Colors.red;
    const maxValue = 20.0;
    const maxColor = Colors.green;
    const value = 0.0;

    await tester.pumpWidget(
      const ColorScaleWidget(
        value: value,
        minValue: minValue,
        minColor: minColor,
        maxValue: maxValue,
        maxColor: maxColor,
        child: SizedBox(),
        colorScaleTypeEnum: ColorScaleTypeEnum.rgb,
      ),
    );

    final ColoredBox container = tester.widget<ColoredBox>(find.byType(ColoredBox));
    expect(container.color, Color.lerp(Colors.red, Colors.green, 0.5));
  });

  test('getColorForValue returns black for NaN and infinity values', () {
    const double minValue = -20;
    const Color minColor = Colors.red;
    const double maxValue = 20;
    const Color maxColor = Colors.green;
    const double nanValue = double.nan;
    const double infinityValue = double.infinity;

    final Color colorForNan = ColorCalculation.getColorForValue(
        nanValue, {minValue: minColor, maxValue: maxColor},
      ColorScaleTypeEnum.rgb,
    );
    final Color colorForInfinity = ColorCalculation.getColorForValue(
      infinityValue, {minValue: minColor, maxValue: maxColor},
      ColorScaleTypeEnum.rgb,
    );

    assert(colorForNan.blue == minColor.blue);
    assert(colorForNan.red == minColor.red);
    assert(colorForNan.green == minColor.green);

    assert(colorForInfinity.blue == maxColor.blue);
    assert(colorForInfinity.red == maxColor.red);
    assert(colorForInfinity.green == maxColor.green);

  });
}
