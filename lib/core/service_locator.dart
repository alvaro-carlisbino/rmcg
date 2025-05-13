import 'package:get_it/get_it.dart';
import 'package:rmcg/presentantion/viewmodels/character_viewmodel.dart';
import '../core/api_client.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  sl.registerFactory<CharacterViewModel>(
    () => CharacterViewModel(api: sl<ApiClient>()),
  );
}
