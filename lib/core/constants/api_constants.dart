class ApiConstants {
  static const String baseUrl = 'https://metreyar-api.onrender.com';
  
  // Endpoints
  static const String materials = '/api/materials';
  static const String materialsSearch = '/api/materials/search';
  static const String estimations = '/api/estimations';
  static const String projects = '/api/projects';
  static const String health = '/api/health';
  
  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
