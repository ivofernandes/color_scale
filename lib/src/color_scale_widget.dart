import 'dart:math';

import 'package:color_scale/src/core/color_calculation.dart';
import 'package:color_scale/src/core/color_scale_type_enum.dart';
import 'package:flutter/material.dart';

/// This widget is a container that have a background color that depends on a value
class ColorScaleWidget extends StatelessWidget {
  /// Value taken in consideration to choose the color
  final double value;

  /// Min vale for the the value ranges
  final double minValue;

  /// Color if the value passed is the minValue
  final Color minColor;

  /// Max value for the value ranges
  final double maxValue;

  /// Color if the value passed is the maxValue
  final Color maxColor;

  /// Widget that will be rendered inside the container
  final Widget? child;

  /// Type of color scale to use: RGB or OKLCH
  final ColorScaleTypeEnum colorScaleTypeEnum;

  const ColorScaleWidget({
      required this.value,
      this.minValue = -20,
      this.maxValue = 20,
      this.minColor = Colors.red,
      this.maxColor = Colors.green,
      this.child,
      this.colorScaleTypeEnum = ColorScaleTypeEnum.hsluv,
      super.key,
      });

  @override
  Widget build(BuildContext context) {
    final Color color = ColorCalculation.getColorForValue(
        value,
        {
          minValue: minColor,
          maxValue: maxColor,
        },
        colorScaleTypeEnum,
    );

    return ColoredBox(
      color: color,
      child: child,
    );
  }
}
