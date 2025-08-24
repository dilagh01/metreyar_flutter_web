// lib/widgets/row_editor.dart
import 'package:flutter/material.dart';
import '../models/row_item.dart';

class RowEditor extends StatefulWidget {
  final RowItem row;
  final void Function(RowItem) onUpdate;

  const RowEditor({required this.row, required this.onUpdate, super.key});

  @override
  _RowEditorState createState() => _RowEditorState();
}

class _RowEditorState extends State<RowEditor> {
  late TextEditingController descController;
  late TextEditingController qtyController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    descController = TextEditingController(text: widget.row.description);
    qtyController = TextEditingController(text: widget.row.quantity.toString());
    priceController = TextEditingController(text: widget.row.unitPrice.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: descController, decoration: const InputDecoration(labelText: 'شرح')),
        TextField(controller: qtyController, decoration: const InputDecoration(labelText: 'مقدار')),
        TextField(controller: priceController, decoration: const InputDecoration(labelText: 'بهای واحد')),
        ElevatedButton(
          onPressed: () {
            final updatedRow = RowItem(
              description: descController.text,
              quantity: double.tryParse(qtyController.text) ?? 0,
              unitPrice: double.tryParse(priceController.text) ?? 0,
            );
            widget.onUpdate(updatedRow);
          },
          child: const Text('به‌روزرسانی'),
        )
      ],
    );
  }
}
