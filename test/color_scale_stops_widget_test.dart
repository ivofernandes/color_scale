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

  test('getColorForValue returns correct color for value 100%', () {
    const value = 100.0;
    final actualColor = ColorCalculation.getColorForValue(
        value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.toARGB32(), Colors.green.toARGB32());
  });
}
