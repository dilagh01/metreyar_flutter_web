import '../models/row_item.dart';

typedef RowSelector = double Function(RowItem row);
typedef RowFilter = bool Function(RowItem row);

class FormulaEvaluator {
  /// محاسبه مجموع کل ردیف‌ها با امکان اعمال ضریب، درصد و فیلتر
  static double calculateTotal(
    List<RowItem> rows, {
    double factor = 1.0,
    double percent = 100.0,
    RowSelector? selector,
    RowFilter? filter,
  }) {
    if (rows.isEmpty) return 0;

    // اگر selector داده نشده، از total استفاده کن
    final select = selector ?? (row) => row.total;

    // اعمال فیلتر اگر داده شده
    final filteredRows = filter != null ? rows.where(filter).toList() : rows;

    double sum = 0;
    for (var row in filteredRows) {
      final value = select(row) ?? 0;
      sum += value * factor * (percent / 100);
    }

    return sum;
  }

  /// محاسبه مجموع یک ستون خاص
  static double calculateColumnTotal(
    List<RowItem> rows,
    RowSelector selector, {
    double factor = 1.0,
    double percent = 100.0,
    RowFilter? filter,
  }) {
    return calculateTotal(
      rows,
      factor: factor,
      percent: percent,
      selector: selector,
      filter: filter,
    );
  }
}
