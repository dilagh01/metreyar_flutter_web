class Environment {
  static const String baseUrl = 'https://metreyar.onrender.com';
  static const String apiVersion = '/api/v1';
  
  // برای توسعه و تولید
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const bool isDevelopment = !isProduction;
}



