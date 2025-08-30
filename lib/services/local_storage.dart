// lib/services/local_storage.dart
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;
  LocalStorage._internal();

  late Box<dynamic> _box;

  Future<void> init() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    _box = await Hive.openBox('metreyar_data');
  }

  Future<void> saveEstimations(List<Map<String, dynamic>> data) async {
    await _box.put('estimations', data);
  }

  List<Map<String, dynamic>> getEstimations() {
    return List<Map<String, dynamic>>.from(_box.get('estimations') ?? []);
  }
}
