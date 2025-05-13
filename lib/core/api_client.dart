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

  Future<Character> fetchCharacterByName(String name) async {
    final uri = Uri.parse('$baseUrl/character/?name=$name');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      if (results.isEmpty) {
        throw Exception('Personagem não encontrado com nome "$name"');
      }
      return Character.fromJson(results.first as Map<String, dynamic>);
    } else {
      throw Exception(
        'Erro ao buscar personagem por nome (status ${response.statusCode})',
      );
    }
  }
}
