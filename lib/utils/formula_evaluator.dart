import '../models/row_item.dart';

class FormulaEvaluator {
  static double calculateTotal(List<RowItem> rows, {double factor = 1.0}) {
    double sum = 0;
    for (var row in rows) {
      sum += row.total * factor;
    }
    return sum;
  }
}
