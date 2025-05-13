# RMCG

Projeto Flutter MVVM para exibir um **Character Card** da API Rick & Morty.

## Descrição

O **RMCG** (Rick & Morty Character Gallery) é um app simples em Flutter que segue o padrão **MVVM** (Model-View-ViewModel) e usa as bibliotecas **GetIt** e **Provider** para gerenciamento de dependências e estado. Ele faz uma requisição HTTP à API oficial do Rick & Morty e exibe um card com as informações principais de um personagem.

## Funcionalidades

* Arquitetura **MVVM** bem estruturada
* Localizador de serviços com **GetIt**
* Gerenciamento de estado com **Provider**
* Cliente HTTP leve usando **http**
* Tela única exibindo card de personagem

## Pré-requisitos

* Flutter SDK (>= 2.10)
* Dart SDK (incluído no Flutter)

## Instalação

1. Clone este repositório:

   ```bash
   git clone https://github.com/seu-usuario/rmcg.git
   cd rmcg
   ```
2. Instale as dependências:

   ```bash
   flutter pub get
   ```
3. Execute o app em um dispositivo ou emulador:

   ```bash
   flutter run
   ```

## Estrutura do Projeto

```
lib/
├── core/                  # Configuração de injeção de dependência e cliente HTTP
│   ├── api_client.dart    # Classe ApiClient para chamadas REST
│   └── service_locator.dart
│
├── data/                  # Modelos de dados e repositórios
│   └── models/
│       └── character.dart # Classe Character e CharacterLocation
│
├── presentation/          # Lógica de UI e estado
│   ├── viewmodels/        # ViewModels (ChangeNotifier)
│   │   └── character_viewmodel.dart
│   └── views/             # Telas e widgets
│       └── character_card_screen.dart
│
└── main.dart              # Ponto de entrada do app
```

## MVVM e GetIt

1. **Model**: `Character` em `data/models/character.dart` com método `fromJson`.
2. **ViewModel**: `CharacterViewModel` em `presentation/viewmodels/character_viewmodel.dart`, estende `ChangeNotifier`.
3. **View**: `CharacterCardScreen` em `presentation/views/character_card_screen.dart`, consome o ViewModel com **Provider**.
4. **Service Locator**: `GetIt` configura `ApiClient` e `CharacterViewModel` em `core/service_locator.dart`.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

*Desenvolvido com ❤️ por Alvaro.*
