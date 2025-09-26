import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8000/query';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['answer'] ?? 'Failed to get a valid answer.';
      } else {
        return 'Error: ${response.statusCode}\nResponse: ${response.body}';
      }
    } catch (e) {
      return 'Error: Could not connect to the server. Is it running?';
    }
  }
}
