import 'package:flutter/material.dart';

class EditableCell extends StatelessWidget {
  final String value;
  final Function(String) onChanged;

  EditableCell({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      style: TextStyle(fontSize: 14),
      onChanged: onChanged,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
