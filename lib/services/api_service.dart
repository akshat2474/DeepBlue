import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // IMPORTANT: Choose the correct URL based on your testing setup
  // Use 'http://10.0.2.2:8000/query' for the Android Emulator
  // Use 'http://127.0.0.1:8000/query' for the iOS Simulator or Web
  // Use your computer's local IP (e.g., 'http://192.168.1.10:8000/query') for a physical device
  static const String _baseUrl = 'http://10.18.181.228:8000/query';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        // The Python backend expects a JSON with a "question" key
        body: jsonEncode({'question': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // The Python backend returns a JSON with an "answer" key
        return data['answer'] ?? 'Failed to get a valid answer.';
      } else {
        // Provide more detailed error information
        return 'Error: ${response.statusCode}\nResponse: ${response.body}';
      }
    } catch (e) {
      // Handle network or connection errors
      return 'Error: Could not connect to the server. Is it running?';
    }
  }
}
