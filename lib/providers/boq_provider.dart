/material.dart';
import '../models/boq_item.dart';

class BOQProvider extends ChangeNotifier {
  List<BOQItem> items = [];

  double get totalCost =>
      items.fold(0, (sum, item) => sum + item.totalPrice);

  void addItem(BOQItem item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void updateItem(int index, BOQItem newItem) {
    items[index] = newItem;
    items[index].recalc();
    notifyListeners();
  }
}
