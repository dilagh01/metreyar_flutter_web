import 'package:flutter_test/flutter_test.dart';
import 'package:metreyar/models/project.dart';

void main() {
  group('Project Model Tests', () {
    test('Project fromJson should work correctly', () {
      final json = {
        'id': 1,
        'name': 'پروژه تست',
        'client': 'کارفرمای تست',
        'location': 'تهران',
        'start_date': '2024-01-01T00:00:00.000Z',
        'status': 'فعال',
        'budget': 1000000.0,
      };

      final project = Project.fromJson(json);

      expect(project.id, 1);
      expect(project.name, 'پروژه تست');
      expect(project.estimatedBudget, 1000000.0);
    });

    test('Project toJson should work correctly', () {
      final project = Project(
        id: 1,
        name: 'پروژه تست',
        client: 'کارفرمای تست',
        location: 'تهران',
        startDate: DateTime(2024, 1, 1),
        status: 'فعال',
        estimatedBudget: 1000000.0,
      );

      final json = project.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'پروژه تست');
      expect(json['budget'], 1000000.0);
    });
  });
}
