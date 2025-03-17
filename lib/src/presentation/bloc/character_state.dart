import 'package:equatable/equatable.dart';

import '../../domain/entities/characters/character_list_entity.dart';

class CharacterState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final CharacterListEntity? characters;
  final List<int> favorites;

  const CharacterState({
    this.isLoading = false,
    this.errorMessage,
    this.characters,
    this.favorites = const [],
  });

  CharacterState copyWith({
    bool? isLoading,
    String? errorMessage,
    CharacterListEntity? characters,
    List<int>? favorites,
  }) {
    return CharacterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      characters: characters ?? this.characters,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, characters, favorites];
}
