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
      value,
      {
        minValue: minColor,
        maxValue: maxColor,
      },
      ColorScaleTypeEnum.rgb,
    );

    expect(_asColorInt(actualColor.b), _asColorInt(expectedColor.b));
    expect(_asColorInt(actualColor.r), _asColorInt(expectedColor.r));
    expect(_asColorInt(actualColor.g), _asColorInt(expectedColor.g));
  });

  testWidgets('ColorScaleWidget renders correct color', (tester) async {
    const value = 0.0;

    await tester.pumpWidget(
      const ColorScaleWidget(
        value: value,
        colorScaleTypeEnum: ColorScaleTypeEnum.rgb,
        child: SizedBox(),
      ),
    );

    final ColoredBox container =
        tester.widget<ColoredBox>(find.byType(ColoredBox));
    expect(container.color, Color.lerp(Colors.red, Colors.green, 0.5));
  });

  test('getColorForValue returns lowest color for NaN and clamps infinity', () {
    const double minValue = -20;
    const Color minColor = Colors.red;
    const double maxValue = 20;
    const Color maxColor = Colors.green;
    const double nanValue = double.nan;
    const double infinityValue = double.infinity;

    final Color colorForNan = ColorCalculation.getColorForValue(
      nanValue,
      {minValue: minColor, maxValue: maxColor},
      ColorScaleTypeEnum.rgb,
    );
    final Color colorForInfinity = ColorCalculation.getColorForValue(
      infinityValue,
      {minValue: minColor, maxValue: maxColor},
      ColorScaleTypeEnum.rgb,
    );

    expect(_asColorInt(colorForNan.b), _asColorInt(minColor.b));
    expect(_asColorInt(colorForNan.r), _asColorInt(minColor.r));
    expect(_asColorInt(colorForNan.g), _asColorInt(minColor.g));

    expect(_asColorInt(colorForInfinity.b), _asColorInt(maxColor.b));
    expect(_asColorInt(colorForInfinity.r), _asColorInt(maxColor.r));
    expect(_asColorInt(colorForInfinity.g), _asColorInt(maxColor.g));
  });

  test('getColorForValue clamps negative infinity to min color', () {
    final actualColor = ColorCalculation.getColorForValue(
      double.negativeInfinity,
      <double, Color>{-20: Colors.red, 20: Colors.green},
      ColorScaleTypeEnum.rgb,
    );

    expect(actualColor.toARGB32(), Colors.red.toARGB32());
  });

  test('getColorForValue returns single stop color for any finite value', () {
    final actualColor = ColorCalculation.getColorForValue(
      123.45,
      <double, Color>{10: Colors.blue},
      ColorScaleTypeEnum.rgb,
    );

    expect(actualColor.toARGB32(), Colors.blue.toARGB32());
  });

  test('getColorForValue throws when color stops are empty', () {
    expect(
      () => ColorCalculation.getColorForValue(
        0,
        <double, Color>{},
        ColorScaleTypeEnum.rgb,
      ),
      throwsArgumentError,
    );
  });
}

int _asColorInt(double component) => (component * 255.0).round() & 0xff;
