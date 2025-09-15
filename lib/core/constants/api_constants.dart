class ApiConstants {
  static const String baseUrl = 'https://metreyar.onrender.com';
  
  // کشف خودکار version API
  static const String apiVersion = 'v1';
  static const String apiPrefix = '/api/$apiVersion';
  
  // Health endpoint
  static const String health = '/health';
  
  // Auth endpoints
  static const String login = '$apiPrefix/auth/login';
  static const String register = '$apiPrefix/auth/register';
  static const String refresh = '$apiPrefix/auth/refresh';
  
  // Materials endpoints
  static const String materials = '$apiPrefix/materials';
  static const String materialsSearch = '$apiPrefix/materials/search';
  static const String materialById = '$apiPrefix/materials/{id}';
  
  // Estimation endpoints
  static const String estimations = '$apiPrefix/estimations';
  static const String estimationById = '$apiPrefix/estimations/{id}';
  static const String estimationCalculate = '$apiPrefix/estimations/calculate';
  
  // Project endpoints
  static const String projects = '$apiPrefix/projects';
  static const String projectById = '$apiPrefix/projects/{id}';
  
  // Analysis endpoints
  static const String analysis = '$apiPrefix/analysis';
  static const String analysisByProject = '$apiPrefix/analysis/project/{projectId}';
  
  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static Map<String, String> authHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
