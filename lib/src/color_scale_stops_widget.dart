import 'package:color_scale/src/core/color_calculation.dart';
import 'package:color_scale/src/core/color_scale_type_enum.dart';
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
  /// Value taken in consideration to choose the color
  final double value;

  /// Map of color stops
  final Map<double, Color> colorStops;

  /// Widget that will be rendered inside the container
  final Widget? child;

  /// Type of color scale to use: RGB or OKLCH
  final ColorScaleTypeEnum colorScaleTypeEnum;

  const ColorScaleStopsWidget({
    required this.value,
    required this.colorStops,
    this.colorScaleTypeEnum = ColorScaleTypeEnum.hsluv,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = ColorCalculation.getColorForValue(
        value, colorStops, ColorScaleTypeEnum.rgb);
    return ColoredBox(
      color: color,
      child: child,
    );
  }
}
