import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rmcg/data/models/character.dart';

class ApiClient {
  final String baseUrl;
  ApiClient({this.baseUrl = 'https://rickandmortyapi.com/api'});

  Future<Character> fetchCharacter(int id) async {
    final uri = Uri.parse('$baseUrl/character/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return Character.fromJson(jsonMap);
    } else {
      throw Exception(
        'Erro ao buscar personagem (status ${response.statusCode})',
      );
    }
  }
}
