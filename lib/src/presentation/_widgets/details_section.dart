part of 'character_card.dart';

class _DetailsSection extends StatelessWidget {
  final CharacterEntity character;
  final bool isLightTheme;

  const _DetailsSection({required this.character, required this.isLightTheme});

  @override
  Widget build(BuildContext context) {
    final textColor = isLightTheme ? nebulaBlue : labWhite;
    final iconColor = isLightTheme ? nebulaBlue : portalGreen;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              character.name,
              style: TextStyle(
                fontFamily: 'GetSchwifty',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isLightTheme ? portalGreen : labWhite,
                letterSpacing: 1.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            _InfoRow(
              icon: Icons.biotech,
              text: character.species,
              iconColor: iconColor,
              textColor: textColor,
            ),
            const SizedBox(height: 4),
            _InfoRow(
              icon: Icons.location_on,
              text: character.location.name,
              iconColor: iconColor,
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final CharacterEntity character;

  const _ImageSection({required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: portalGreen.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              character.image,
              width: 120,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Container(
                    width: 120,
                    height: 150,
                    color: dimensionGrey,
                    child: const Icon(Icons.broken_image, color: labWhite),
                  ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.black.withOpacity(0.7),
              child: Text(
                character.status,
                style: TextStyle(
                  color: _getStatusColor(character.status),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return portalGreen;
      case 'dead':
        return bloodRed;
      case 'unknown':
        return dimensionGrey;
      default:
        return labWhite;
    }
  }
}

class _Background extends StatelessWidget {
  final bool isLightTheme;

  const _Background({required this.isLightTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors:
              isLightTheme
                  ? [Colors.white, Colors.grey.shade200]
                  : [cosmicBlack, nebulaBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final CharacterEntity character;
  final bool isLightTheme;

  const _Content({required this.character, required this.isLightTheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ImageSection(character: character),
        _DetailsSection(character: character, isLightTheme: isLightTheme),
      ],
    );
  }
}
