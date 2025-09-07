import 'package:flutter/material.dart';
import '../models/boq_item.dart';

class BOQProvider extends ChangeNotifier {
  final List<BOQItem> _items = [];

  List<BOQItem> get items => List.unmodifiable(_items);

  void addItem(BOQItem item) {
    _items.add(item);
    notifyListeners();
  }

  void updateItem(int index, BOQItem item) {
    if (index >= 0 && index < _items.length) {
      _items[index] = item;
      notifyListeners();
    }
  }

  void removeItem(BOQItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeItemAt(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  double get totalCost {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
