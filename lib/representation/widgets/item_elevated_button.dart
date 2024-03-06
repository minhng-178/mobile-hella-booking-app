import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/color_palette.dart';

enum ButtonVariant { primary, secondary }

class ItemElevatedButton extends StatelessWidget {
  final ButtonVariant variant;
  final Function()? onPressed;
  final String title;

  const ItemElevatedButton(
      {super.key, required this.variant, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Widget button;

    switch (variant) {
      case ButtonVariant.primary:
        buttonColor = ColorPalette.primaryColor;
        button = ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(title),
        );
        break;
      case ButtonVariant.secondary:
        buttonColor = ColorPalette.primaryColor;
        button = OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: buttonColor,
            side: BorderSide(color: buttonColor, width: 2.0),
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          onPressed: onPressed,
          child: Text(title),
        );
        break;
      default:
        buttonColor = Colors.grey;
        button = ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(title),
        );
    }

    return button;
  }
}
