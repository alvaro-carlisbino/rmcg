import 'package:flutter/material.dart';

class CartaPersonagem extends StatelessWidget {
  final dynamic character;
  final bool isWide;

  const CartaPersonagem({
    super.key,
    required this.character,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (character.status.toLowerCase()) {
      case 'alive':
        statusColor = Colors.green[400]!;
        break;
      case 'dead':
        statusColor = Colors.red[400]!;
        break;
      default:
        statusColor = Colors.amber[400]!;
    }

    String statusText = character.status;
    if (character.status.toLowerCase() == 'alive') {
      statusText = 'Vivo';
    } else if (character.status.toLowerCase() == 'dead') {
      statusText = 'Morto';
    } else {
      statusText = 'Desconhecido';
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.4),
            blurRadius: 24,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF1E2A3A),
                    const Color(0xFF0D1218),
                  ],
                ),
                border: Border.all(
                  color: statusColor.withOpacity(0.8),
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCardHeader(statusColor),
                
                _buildCharacterImage(statusColor, statusText, isWide),
                
                _buildNameBanner(statusColor),
                
                _buildCharacterInfo(),
                
                _buildCharacterStats(statusColor),
              ],
            ),

            ...buildCornerAccents(statusColor),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            statusColor.withOpacity(0.9),
            statusColor.withOpacity(0.4),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "#${character.id.toString().padLeft(3, '0')}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    Icon(
                      character.gender.toLowerCase() == 'male'
                          ? Icons.male
                          : character.gender.toLowerCase() == 'female'
                              ? Icons.female
                              : Icons.question_mark,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _traduzirGenero(character.gender),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Text(
              'RMCG',
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterImage(Color statusColor, String statusText, bool isWide) {
    return SizedBox(
      height: isWide ? 380 : 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.black26,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.white54,
                            size: 64,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                        stops: const [0.7, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor.withOpacity(0.8), width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(
                    _getSpeciesIcon(character.species),
                    color: statusColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    character.species,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: statusColor.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withOpacity(0.8),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameBanner(Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            statusColor.withOpacity(0.9),
            statusColor.withOpacity(0.5),
            statusColor.withOpacity(0.9),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        character.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              blurRadius: 8.0,
              color: Colors.black.withOpacity(0.7),
              offset: const Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            Icons.public,
            'Origem:',
            character.origin.name,
          ),
          const SizedBox(height: 14),
          _buildInfoRow(
            Icons.location_on,
            'Localização:',
            character.location.name,
          ),
          const SizedBox(height: 14),
          _buildInfoRow(
            character.type.isEmpty ? Icons.person_outline : Icons.psychology,
            'Tipo:',
            character.type.isEmpty ? 'Não especificado' : character.type,
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterStats(Color statusColor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.movie, 'Episódios', character.episode.length.toString(), statusColor),
          _buildStatItem(
              Icons.auto_awesome, 
              'Aparição', 
              _calculateAppearanceRating(character.episode.length), 
              statusColor),
          _buildStatItem(
              Icons.calendar_today, 
              'Criado', 
              _formatDate(character.created), 
              statusColor),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white70, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value, Color statusColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
            border: Border.all(color: statusColor.withOpacity(0.7), width: 1.5),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  List<Widget> buildCornerAccents(Color statusColor) {
    return [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: statusColor, width: 3),
              left: BorderSide(color: statusColor, width: 3),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: statusColor, width: 3),
              right: BorderSide(color: statusColor, width: 3),
            ),
          ),
        ),
      ),
    ];
  }

  String _traduzirGenero(String genero) {
    switch (genero.toLowerCase()) {
      case 'male':
        return 'Masculino';
      case 'female':
        return 'Feminino';
      case 'genderless':
        return 'Sem gênero';
      default:
        return 'Desconhecido';
    }
  }

  IconData _getSpeciesIcon(String species) {
    switch (species.toLowerCase()) {
      case 'human':
        return Icons.person;
      case 'alien':
        return Icons.public;
      case 'robot':
      case 'cronenberg':
        return Icons.smart_toy;
      case 'animal':
        return Icons.pets;
      case 'mythological creature':
        return Icons.auto_fix_high;
      case 'poopybutthole':
        return Icons.mood;
      case 'disease':
        return Icons.coronavirus;
      default:
        return Icons.category;
    }
  }

  String _calculateAppearanceRating(int episodeCount) {
    if (episodeCount > 15) return 'Alta';
    if (episodeCount > 5) return 'Média';
    return 'Baixa';
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }
}