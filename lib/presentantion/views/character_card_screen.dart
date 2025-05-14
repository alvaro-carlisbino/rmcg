import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmcg/core/service_locator.dart';
import 'package:rmcg/presentantion/cards/character_card.dart';
import 'package:rmcg/presentantion/viewmodels/character_viewmodel.dart';

class CharacterCardScreen extends StatefulWidget {
  const CharacterCardScreen({Key? key}) : super(key: key);

  @override
  _CharacterCardScreenState createState() => _CharacterCardScreenState();
}

class _CharacterCardScreenState extends State<CharacterCardScreen> {
  late final TextEditingController _searchController;
  late final CharacterViewModel _viewModel;
  final _focusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _viewModel = sl<CharacterViewModel>()..loadCharacter(1);
    _focusNode.addListener(() {
      setState(() {
        _isSearchFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    _viewModel.searchCharacter(query);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharacterViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1B2631), Color(0xFF17202A)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<CharacterViewModel>(
                        builder: (_, vm, __) {
                          if (vm.character != null) {
                            return ClipOval(
                              child: Image.network(
                                vm.character!.image,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                              ),
                            );
                          } else {
                            return const CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(Icons.person, color: Colors.white),
                            );
                          }
                        },
                      ),
                      Text(
                        'RMCG – Card Game',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.white70),
                        onPressed: () => _viewModel.loadCharacter(1),
                      ),
                    ],
                  ),
                ),

                AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: _isSearchFocused ? 24 : 16,
                  ),
                  height: 60,
                  decoration: BoxDecoration(
                    color:
                        _isSearchFocused
                            ? Colors.white.withOpacity(0.15)
                            : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color:
                          _isSearchFocused
                              ? Colors.red.withOpacity(0.8)
                              : Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                    boxShadow:
                        _isSearchFocused
                            ? [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                            : [],
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _focusNode,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _onSearch(),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar por nome, ID...',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color:
                            _isSearchFocused
                                ? Colors.red[300]
                                : Colors.white70,
                      ),
                      suffixIcon:
                          _searchController.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  _viewModel.loadCharacter(1);
                                },
                              )
                              : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Consumer<CharacterViewModel>(
                    builder: (_, vm, __) {
                      if (vm.isLoading) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green[300]!,
                                  ),
                                  strokeWidth: 3,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Carregando personagem...',
                                style: TextStyle(
                                  color: Colors.green[200],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (vm.error != null) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 70,
                                  color: Colors.red[300],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Personagem não encontrado',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[300],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tente pesquisar por outro personagem',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final character = vm.character!;
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 600;

                          return Center(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: isWide ? 500 : double.infinity,
                                ),
                                child: CartaPersonagem(
                                  character: character,
                                  isWide: isWide,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
