import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DialogProvider extends ChangeNotifier {
  void showDialog(
      String type, String title, String desc, BuildContext context) {
    DialogType dialogType = DialogType.info;
    if (type == 'success') {
      dialogType = DialogType.success;
    } else if (type == 'error') {
      dialogType = DialogType.error;
    } else if (type == 'warning') {
      dialogType = DialogType.warning;
    }

    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
    )..show();
  }
}
