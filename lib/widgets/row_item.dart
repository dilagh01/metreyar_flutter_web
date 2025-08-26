import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  final String col1;
  final String col2;

  const RowItem({Key? key, required this.col1, required this.col2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            col1,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            col2,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
