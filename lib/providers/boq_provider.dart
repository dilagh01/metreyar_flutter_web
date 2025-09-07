import 'package:flutter/material.dart';
import '../models/boq_item.dart';

class BOQProvider extends ChangeNotifier {
  List<BOQItem> _items = [];

  List<BOQItem> get items => _items;

  void addItem(BOQItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(BOQItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateItem(int index, BOQItem newItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = newItem;
      notifyListeners();
    }
  }

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
