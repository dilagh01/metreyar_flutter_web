// lib/providers/estimation_provider.dart
import 'package:flutter/foundation.dart';
import '../models/row_item.dart';

class EstimationProvider with ChangeNotifier {
  List<RowItem> _items = [];

  List<RowItem> get items => _items;

  double get grandTotal {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(RowItem item) {
    _items.add(item);
    notifyListeners();
  }

  void updateItem(int index, RowItem newItem) {
    _items[index] = newItem;
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }

  Map<String, double> getCategoryTotals() {
    Map<String, double> totals = {};
    for (var item in _items) {
      totals[item.category] = (totals[item.category] ?? 0) + item.totalPrice;
    }
    return totals;
  }
}
