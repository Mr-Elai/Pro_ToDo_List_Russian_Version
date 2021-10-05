import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';


class WheelRadarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RadarChart(
          values: [5.2, 8, 4.7, 4.2, 6.4, 7.3, 5.6, 6],
          labels: [
            "Brightness of life",
            "Material",
            "Health",
            "Career",
            "Family, friends",
            "Relationship",
            "Finance",
            "Self-development",
          ],
          maxWidth: 300.0,
          maxHeight: 300.0,
          labelColor: ColorPalette.black1,
          fillColor: ColorPalette.purple1,
          maxValue: 10,
          strokeColor: ColorPalette.strokeColor,
          chartRadiusFactor: 0.7,
        );
  }
}
