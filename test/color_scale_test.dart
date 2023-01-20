import 'package:color_scale/src/color_scale_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getColorForValue returns correct color for value', () {
    final minValue = -20.0;
    final minColor = Colors.red;
    final maxValue = 20.0;
    final maxColor = Colors.green;
    final value = 0.0;

    final expectedColor = Color.lerp(Colors.red, Colors.green, 0.5);
    final actualColor = ColorScaleWidget.getColorForValue(
        value, minValue, minColor, maxValue, maxColor);

    expect(actualColor, expectedColor);
  });

  testWidgets('ColorScaleWidget renders correct color', (tester) async {
    final minValue = -20.0;
    final minColor = Colors.red;
    final maxValue = 20.0;
    final maxColor = Colors.green;
    final value = 0.0;

    await tester.pumpWidget(
      ColorScaleWidget(
        value: value,
        minValue: minValue,
        minColor: minColor,
        maxValue: maxValue,
        maxColor: maxColor,
        child: const SizedBox(),
      ),
    );

    final container = tester.widget<Container>(find.byType(Container));
    expect(container.color, Color.lerp(Colors.red, Colors.green, 0.5));
  });

  test('getColorForValue returns black for NaN and infinity values', () {
    final minValue = -20.0;
    final minColor = Colors.red;
    final maxValue = 20.0;
    final maxColor = Colors.green;
    final nanValue = double.nan;
    final infinityValue = double.infinity;

    final colorForNan = ColorScaleWidget.getColorForValue(
        nanValue, minValue, minColor, maxValue, maxColor);
    final colorForInfinity = ColorScaleWidget.getColorForValue(
        infinityValue, minValue, minColor, maxValue, maxColor);

    expect(colorForNan, Colors.black);
    expect(colorForInfinity, Colors.black);
  });
}
