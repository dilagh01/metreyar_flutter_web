// lib/core/config/api_endpoints.dart
class ApiEndpoints {
  static String get projects => '/projects';
  static String project(int id) => '/projects/$id';
  static String projectBoq(int projectId) => '/projects/$projectId/boq';
  static String projectBoqAnalyze(int projectId) => '/projects/$projectId/boq/analyze';
  static String get priceBooks => '/price-books';
  static String get resources => '/resources';
  static String get analyses => '/analyses';
  
  static String buildUrl(String endpoint) {
    return '${Environment.baseUrl}${Environment.apiVersion}$endpoint';
  }
}
