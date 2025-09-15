import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  String? _cachedPrefix;

  ApiService({required this.baseUrl, required this.client});

  Future<String> _discoverApiVersion() async {
    if (_cachedPrefix != null) return _cachedPrefix!;

    final versions = ['/api/v1', '/api', ''];

    for (final v in versions) {
      try {
        final res = await client.get(
          Uri.parse('$baseUrl$v/health'),
          headers: ApiConstants.headers,
        );
        if (res.statusCode == 200) {
          _cachedPrefix = v;
          return v;
        }
      } catch (_) {}
    }

    return '/api/v1'; // fallback
  }

  Future<http.Response> get(String endpoint) async {
    final prefix = await _discoverApiVersion();
    final url = Uri.parse('$baseUrl$prefix$endpoint');
    return await client.get(url, headers: ApiConstants.headers);
  }
}
