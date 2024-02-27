import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/color_palette.dart';

class DashLineWidget extends StatelessWidget {
  const DashLineWidget(
      {super.key, this.height = 1, this.color = ColorPalette.dividerColor});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
