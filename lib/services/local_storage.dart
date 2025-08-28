// services/local_storage.dart
class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;
  LocalStorage._internal();

  late Box<dynamic> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('estimation_data');
  }

  Future<void> saveEstimations(List<Map<String, dynamic>> data) async {
    await _box.put('estimations', data);
  }

  List<Map<String, dynamic>> getEstimations() {
    return List<Map<String, dynamic>>.from(_box.get('estimations') ?? []);
  }
}
