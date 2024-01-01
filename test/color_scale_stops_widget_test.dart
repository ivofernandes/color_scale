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
    final Color actualColor =
    ColorCalculation.getColorForValue(value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.value, Colors.red.value);
  });

  test('getColorForValue returns correct color for value 25%', () {
    const value = 25.0;

    final expectedColor = Color.lerp(Colors.red, Colors.yellow, 0.5);
    final actualColor =
    ColorCalculation.getColorForValue(value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor, expectedColor);
  });

  test('getColorForValue returns correct color for value 50%', () {
    const value = 50.0;
    final actualColor =
    ColorCalculation.getColorForValue(value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.value, Colors.yellow.value);
  });

  testWidgets('ColorScaleStopsWidget renders correct color 75%',
      (tester) async {
    const value = 75.0;

    await tester.pumpWidget(
      ColorScaleStopsWidget(
        value: value,
        colorStops: colorStops,
        child: const SizedBox(),
      ),
    );

    final container = tester.widget<ColoredBox>(find.byType(ColoredBox));
    expect(container.color, Color.lerp(Colors.green, Colors.yellow, 0.5));
  });

  test('getColorForValue returns correct color for value 100%', () {
    const value = 100.0;
    final actualColor =
        ColorCalculation.getColorForValue(value, colorStops, ColorScaleTypeEnum.rgb);

    expect(actualColor.value, Colors.green.value);
  });
}
