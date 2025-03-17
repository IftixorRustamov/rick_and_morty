import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/domain/usecases/add_to_favorites_usecases.dart';
import 'package:rick_and_morty/src/domain/usecases/get_characters_usecases.dart';
import 'package:rick_and_morty/src/domain/usecases/get_favorite_characters_usecases.dart';
import 'package:rick_and_morty/src/domain/usecases/remove_from_favorites_usecases.dart';
import 'character_event.dart';
import 'character_state.dart';
import 'dart:developer' as developer;

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharactersUsecases _getCharacters;
  final GetFavoriteCharactersUsecases _getFavoriteCharacters;
  final AddToFavoritesUsecases _addToFavorites;
  final RemoveFromFavoritesUsecases _removeFromFavorites;

  CharacterBloc({
    required GetCharactersUsecases getCharacters,
    required GetFavoriteCharactersUsecases getFavoriteCharacters,
    required AddToFavoritesUsecases addToFavorites,
    required RemoveFromFavoritesUsecases removeFromFavorites,
  }) : _getCharacters = getCharacters,
       _getFavoriteCharacters = getFavoriteCharacters,
       _addToFavorites = addToFavorites,
       _removeFromFavorites = removeFromFavorites,
       super(const CharacterState()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);

    // Initial load
    add(const LoadCharacters(1));
    add(const LoadFavorites());
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    developer.log('Loading characters for page ${event.page}');
    final result = await _getCharacters(event.page);
    result.fold(
      (exception) {
        developer.log('Error loading characters: $exception');
        emit(
          state.copyWith(isLoading: false, errorMessage: exception.toString()),
        );
      },
      (characterList) {
        developer.log(
          'Characters loaded: ${characterList.results.length} items',
        );
        emit(state.copyWith(isLoading: false, characters: characterList));
      },
    );
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<CharacterState> emit,
  ) async {
    developer.log('Loading favorites');
    final result = await _getFavoriteCharacters();
    result.fold(
      (exception) {
        developer.log('Error loading favorites: ${exception.message}');
        emit(state.copyWith(errorMessage: exception.message));
      },
      (favorites) {
        final favoriteIds = favorites.map((char) => char.id).toList();
        developer.log('Favorites loaded: ${favoriteIds.length} items');
        emit(state.copyWith(favorites: favoriteIds));
      },
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<CharacterState> emit,
  ) async {
    final characterId = event.character.id;
    final isFavorite = state.favorites.contains(characterId);
    developer.log('Toggling favorite for character $characterId: $isFavorite');
    if (isFavorite) {
      final result = await _removeFromFavorites(characterId);
      result.fold(
        (exception) {
          developer.log('Error removing from favorites: ${exception.message}');
          emit(state.copyWith(errorMessage: exception.message));
        },
        (_) {
          developer.log('Successfully removed from favorites');
          emit(
            state.copyWith(
              favorites:
                  state.favorites.where((id) => id != characterId).toList(),
            ),
          );
        },
      );
    } else {
      final result = await _addToFavorites(event.character);
      result.fold(
        (exception) {
          developer.log('Error adding to favorites: ${exception.message}');
          emit(state.copyWith(errorMessage: exception.message));
        },
        (_) {
          developer.log('Successfully added to favorites');
          emit(state.copyWith(favorites: [...state.favorites, characterId]));
        },
      );
    }
  }
}
