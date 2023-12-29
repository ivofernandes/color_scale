import 'package:flutter/material.dart';

/// This ColorScaleStopsWidget works by first checking if the value
/// is lower or higher than the lowest or highest stop respectively.
///
/// If it is, it returns the corresponding color.
/// If it's within the range of the stops, it finds the two closest stops
/// to the value and calculates the percentage of each stop's color
/// based on the value.
///
/// Finally, it mixes the two colors based on their percentages
/// to get the final color for the value.
class ColorScaleStopsWidget extends StatelessWidget {
  final double value;
  final Map<double, Color> colorStops;
  final Widget? child;

  const ColorScaleStopsWidget({
    required this.value,
    required this.colorStops,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = getColorForValue(value, colorStops);
    return Container(
      color: color,
      child: child,
    );
  }

  static Color getColorForValue(double value, Map<double, Color> colorStops) {
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
    for (var stop in colorStops.keys) {
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
}
