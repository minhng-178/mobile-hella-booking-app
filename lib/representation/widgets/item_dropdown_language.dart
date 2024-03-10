import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';

class ItemDropdownLanguage extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String?>? validator;

  const ItemDropdownLanguage({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: DropdownButtonFormField<String>(
          value: value,
          hint: Text('Select Language',
              style: TextStyle(color: Colors.grey[500])),
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintStyle: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          items: <String>['Vietnamese', 'English']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}
