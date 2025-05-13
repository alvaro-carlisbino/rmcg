import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmcg/presentantion/viewmodels/character_viewmodel.dart';
import '../../core/service_locator.dart';

class CharacterCardScreen extends StatelessWidget {
  const CharacterCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharacterViewModel>(
      create: (_) {
        final vm = sl<CharacterViewModel>();
        vm.loadCharacter(1); 
        return vm;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('RMCG – Character Card')),
        body: Consumer<CharacterViewModel>(
          builder: (_, vm, __) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.error != null) {
              return Center(child: Text('Erro: ${vm.error}'));
            }
            final c = vm.character!;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(c.image, fit: BoxFit.cover),
                    ),
                    ListTile(
                      title: Text(c.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      subtitle: Text('${c.species} • ${c.status}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Origem: ${c.origin.name}'),
                          Text('Local: ${c.location.name}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
