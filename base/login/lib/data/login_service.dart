import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String baseUrl = 'https://hackaton-rails-api.duckdns.org:3000/users';

  Future<Map<String, dynamic>?> getUserByName(String name) async {
    final url = Uri.parse('$baseUrl/?name=$name');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return null;
    }
  }
}
