import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common/constants/app_colors.dart';
import '../../domain/entities/characters/character_entity.dart';
import '../bloc/character_bloc.dart';
import 'favorite_button.dart';

part 'info_row.dart';

part 'details_section.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final VoidCallback onFavoriteToggle;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;
    final isFavorite = state.favorites.contains(character.id);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: portalGreen, width: 1.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _showTappedSnackBar(context),
        child: Stack(
          children: [
            _Background(
              isLightTheme: Theme.of(context).brightness == Brightness.light,
            ),
            _Content(
              character: character,
              isLightTheme: Theme.of(context).brightness == Brightness.light,
            ),
            FavoriteButton(
              isFavorite: isFavorite,
              onToggle: onFavoriteToggle,
              isLightTheme: Theme.of(context).brightness == Brightness.light,
            ),
          ],
        ),
      ),
    );
  }

  void _showTappedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Wubba Lubba Dub Dub! ${character.name} tapped!')),
    );
  }
}
