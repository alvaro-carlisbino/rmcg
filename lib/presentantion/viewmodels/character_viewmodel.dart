import 'package:flutter/foundation.dart';
import 'package:rmcg/core/api_client.dart';
import 'package:rmcg/data/models/character.dart';

class CharacterViewModel extends ChangeNotifier {
  final ApiClient api;
  Character? character;
  bool isLoading = false;
  String? error;

  CharacterViewModel({required this.api});

  Future<void> loadCharacter(int id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      character = await api.fetchCharacter(id);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
