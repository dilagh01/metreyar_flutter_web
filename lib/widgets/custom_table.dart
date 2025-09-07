import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/boq_item.dart';
import '../providers/boq_provider.dart';
import 'editable_cell.dart';

class CustomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BOQProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text("شرح")),
          DataColumn(label: Text("واحد")),
          DataColumn(label: Text("تعداد")),
          DataColumn(label: Text("بها")),
          DataColumn(label: Text("جمع")),
          DataColumn(label: Text("حذف")),
        ],
        rows: List.generate(provider.items.length, (index) {
          final item = provider.items[index];
          return DataRow(cells: [
            DataCell(EditableCell(
              value: item.description,
              onChanged: (v) {
                provider.updateItem(index,
                    BOQItem(id: item.id, description: v, unit: item.unit, quantity: item.quantity, unitPrice: item.unitPrice));
              },
            )),
            DataCell(EditableCell(
              value: item.unit,
              onChanged: (v) {
                provider.updateItem(index,
                    BOQItem(id: item.id, description: item.description, unit: v, quantity: item.quantity, unitPrice: item.unitPrice));
              },
            )),
            DataCell(EditableCell(
              value: item.quantity.toString(),
              onChanged: (v) {
                final qty = double.tryParse(v) ?? 0;
                provider.updateItem(index,
                    BOQItem(id: item.id, description: item.description, unit: item.unit, quantity: qty, unitPrice: item.unitPrice));
              },
            )),
            DataCell(EditableCell(
              value: item.unitPrice.toString(),
              onChanged: (v) {
                final price = double.tryParse(v) ?? 0;
                provider.updateItem(index,
                    BOQItem(id: item.id, description: item.description, unit: item.unit, quantity: item.quantity, unitPrice: price));
              },
            )),
            DataCell(Text(item.totalPrice.toStringAsFixed(0))),
            DataCell(IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => provider.removeItem(index),
            )),
          ]);
        }),
      ),
    );
  }
}
