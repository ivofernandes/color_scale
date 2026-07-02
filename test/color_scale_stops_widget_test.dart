import 'package:color_scale/src/color_scale_stops_widget.dart';
import 'package:color_scale/src/core/color_calculation.dart';
import 'package:color_scale/src/core/color_scale_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final colorStops = <double, Color>{
    0: Colors.red,
    50: Colors.yellow,
    100: Colors.green,
  };

  test('getColorForValue returns correct color for value 0%', () {
    const value = 0.0;
    final Color actualColor = ColorCalculation.getColorForValue(
        value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.toARGB32(), Colors.red.toARGB32());
  });

  test('getColorForValue returns correct color for value 25%', () {
    const value = 25.0;

    final actualColor = ColorCalculation.getColorForValue(
        value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.toARGB32(), const Color(0xFFF99738).toARGB32());
  });

  test('getColorForValue returns correct color for value 50%', () {
    const value = 50.0;
    final actualColor = ColorCalculation.getColorForValue(
        value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.toARGB32(), Colors.yellow.toARGB32());
  });

  testWidgets('ColorScaleStopsWidget renders correct color 75%',
      (tester) async {
    const value = 75.0;

    await tester.pumpWidget(
      ColorScaleStopsWidget(
        value: value,
        colorStops: colorStops,
        colorScaleTypeEnum: ColorScaleTypeEnum.rgb,
        child: const SizedBox(),
      ),
    );

    final container = tester.widget<ColoredBox>(find.byType(ColoredBox));
    expect(container.color.toARGB32(), const Color(0xFFA5CD45).toARGB32());
  });

  test('getColorForValue handles intentionally unsorted color stops', () {
    final unsortedColorStops = <double, Color>{
      100: Colors.green,
      0: Colors.red,
      50: Colors.yellow,
    };

    final actualColor = ColorCalculation.getColorForValue(
        25, unsortedColorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.toARGB32(), const Color(0xFFF99738).toARGB32());
  });

  testWidgets('ColorScaleStopsWidget handles intentionally unsorted color stops',
      (tester) async {
    final unsortedColorStops = <double, Color>{
      100: Colors.green,
      0: Colors.red,
      50: Colors.yellow,
    };

    await tester.pumpWidget(
      ColorScaleStopsWidget(
        value: 75,
        colorStops: unsortedColorStops,
        colorScaleTypeEnum: ColorScaleTypeEnum.rgb,
        child: const SizedBox(),
      ),
    );

    final container = tester.widget<ColoredBox>(find.byType(ColoredBox));
    expect(container.color.toARGB32(), const Color(0xFFA5CD45).toARGB32());
  });

  test('getColorForValue throws when color stops are empty', () {
    expect(
      () => ColorCalculation.getColorForValue(
          25, <double, Color>{}, ColorScaleTypeEnum.rgb),
      throwsArgumentError,
    );
  });

  test('getColorForValue returns lowest stop color for NaN', () {
    final actualColor = ColorCalculation.getColorForValue(
        double.nan, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.toARGB32(), Colors.red.toARGB32());
  });

  test('getColorForValue clamps infinite values to edge stop colors', () {
    final negativeInfinityColor = ColorCalculation.getColorForValue(
        double.negativeInfinity, colorStops, ColorScaleTypeEnum.rgb);
    final positiveInfinityColor = ColorCalculation.getColorForValue(
        double.infinity, colorStops, ColorScaleTypeEnum.rgb);

    expect(negativeInfinityColor.toARGB32(), Colors.red.toARGB32());
    expect(positiveInfinityColor.toARGB32(), Colors.green.toARGB32());
  });

  test('getColorForValue returns single stop color for any finite value', () {
    final actualColor = ColorCalculation.getColorForValue(
        75, const {50: Colors.purple}, ColorScaleTypeEnum.rgb);

    expect(actualColor.toARGB32(), Colors.purple.toARGB32());
  });

  testWidgets('ColorScaleStopsWidget renders single stop color', (tester) async {
    await tester.pumpWidget(
      const ColorScaleStopsWidget(
        value: 75,
        colorStops: {50: Colors.purple},
        colorScaleTypeEnum: ColorScaleTypeEnum.rgb,
        child: SizedBox(),
      ),
    );

    final container = tester.widget<ColoredBox>(find.byType(ColoredBox));
    expect(container.color.toARGB32(), Colors.purple.toARGB32());
  });

  test('getColorForValue returns correct color for value 100%', () {
    const value = 100.0;
    final actualColor = ColorCalculation.getColorForValue(
        value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.toARGB32(), Colors.green.toARGB32());
  });
}
