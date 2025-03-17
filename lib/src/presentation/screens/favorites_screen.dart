import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/common/constants/app_colors.dart';
import 'package:rick_and_morty/src/presentation/bloc/character_bloc.dart';
import 'package:rick_and_morty/src/presentation/bloc/character_event.dart';
import 'package:rick_and_morty/src/presentation/bloc/character_state.dart';
import '../_widgets/character_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _sortBy = 'name'; // Default sort by name

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(const LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontFamily: 'GetSchwifty',
            fontSize: 26,
            color: portalGreen,
          ),
        ),
        backgroundColor: isLightTheme ? Colors.white : const Color(0xFF1A1A2E),
        // Cosmic Black
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => _sortBy = value),
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: 'name', child: Text('Name')),
                  const PopupMenuItem(value: 'status', child: Text('Status')),
                ],
            icon: const Icon(Icons.sort, color: labWhite),
          ),
        ],
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return Center(
              child: Text(
                'No Favorites, Morty!',
                style: TextStyle(
                  fontFamily: 'GetSchwifty',
                  fontSize: 24,
                  color: isLightTheme ? nebulaBlue : labWhite,
                ),
              ),
            );
          }

          final allCharacters = state.characters?.results ?? [];
          final favoriteCharacters =
              allCharacters
                  .where((char) => state.favorites.contains(char.id))
                  .toList();

          if (favoriteCharacters.isEmpty && state.favorites.isNotEmpty) {
            return const Center(child: Text('Loading favorites...'));
          }

          final sortedFavorites = List.from(favoriteCharacters)..sort(
            (a, b) =>
                _sortBy == 'name'
                    ? a.name.compareTo(b.name)
                    : a.status.compareTo(b.status),
          );

          return ListView.builder(
            itemCount: sortedFavorites.length,
            itemBuilder: (context, index) {
              final character = sortedFavorites[index];
              return CharacterCard(
                key: ValueKey(character.id),
                character: character,
                onFavoriteToggle:
                    () => context.read<CharacterBloc>().add(
                      ToggleFavorite(character),
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
