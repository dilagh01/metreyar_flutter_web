class ApiService {
  static const String baseUrl = 'https://metreyar.onrender.com';

  static Future<Map<String, dynamic>> _request(
    String method, 
    String endpoint, 
    dynamic data
  ) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      print('🌐 API Call: $method $url');
      
      final headers = {'Content-Type': 'application/json'};
      final body = data != null ? json.encode(data) : null;
      
      http.Response response;
      
      if (method == 'POST') {
        response = await http.post(url, headers: headers, body: body);
      } else {
        response = await http.get(url, headers: headers);
      }
      
      print('📡 Response Status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API Connection Error: $e');
      throw Exception('Connection failed: $e');
    }
  }

  // دریافت مواد اولیه
  static Future<List<dynamic>> getMaterials() async {
    try {
      final response = await _request('GET', '/api/materials', null);
      return response['materials'] ?? [];
    } catch (e) {
      print('❌ Error getting materials: $e');
      return [];
    }
  }

  // محاسبه برآورد
  static Future<Map<String, dynamic>> calculateEstimation(Map<String, dynamic> data) async {
    return await _request('POST', '/api/calculate/estimation', data);
  }

  // دریافت پروژه‌ها
  static Future<List<dynamic>> getProjects() async {
    try {
      final response = await _request('GET', '/api/projects', null);
      return response ?? [];
    } catch (e) {
      print('❌ Error getting projects: $e');
      return [];
    }
  }

  // ایجاد پروژه جدید
  static Future<Map<String, dynamic>> createProject(Map<String, dynamic> data) async {
    return await _request('POST', '/api/projects', data);
  }
}
