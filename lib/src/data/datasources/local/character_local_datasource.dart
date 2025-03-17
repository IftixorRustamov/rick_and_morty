import 'package:rick_and_morty/src/data/models/character/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<void> cacheCharacters(List<CharacterModel> characters);

  Future<List<CharacterModel>> getCachedCharacters();

  Future<List<CharacterModel>> getFavoriteCharacters();

  Future<void> addToFavorites(CharacterModel character);

  Future<void> removeFromFavorites(int characterId);
}
