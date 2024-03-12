import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';

class ItemDropdownLanguage extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String?>? validator;

  ItemDropdownLanguage({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  final itemsMap = {'Vietnamese': 'vn', 'English': 'en'};

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
          items: itemsMap.entries.map<DropdownMenuItem<String>>((entry) {
            return DropdownMenuItem<String>(
              value: entry.value,
              child: Text(entry.key),
            );
          }).toList(),
        ));
  }
}
