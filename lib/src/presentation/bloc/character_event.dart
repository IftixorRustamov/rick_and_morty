import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_entity.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object?> get props => [];
}

class LoadCharacters extends CharacterEvent {
  final int page;

  const LoadCharacters(this.page);

  @override
  List<Object?> get props => [page];
}

class LoadFavorites extends CharacterEvent {
  const LoadFavorites();
}

class ToggleFavorite extends CharacterEvent {
  final CharacterEntity character;

  const ToggleFavorite(this.character);

  @override
  List<Object?> get props => [character];
}