import 'package:hive/hive.dart';
import 'package:rick_and_morty/src/data/datasources/local/character_local_datasource.dart';
import 'package:rick_and_morty/src/data/models/character/character_model.dart';

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final Box<CharacterModel> characterBox;
  final Box<CharacterModel> favoritesBox;

  CharacterLocalDataSourceImpl({
    required this.characterBox,
    required this.favoritesBox,
  });

  @override
  Future<void> addToFavorites(CharacterModel character) async {
    await favoritesBox.put(character.id, character.copyWith(isFavorite: true));
  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    await characterBox.clear();
    await characterBox.addAll(characters);
  }

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    return characterBox.values.toList();
  }

  @override
  Future<List<CharacterModel>> getFavoriteCharacters() async {
    return favoritesBox.values.toList();
  }

  @override
  Future<void> removeFromFavorites(int characterId) async {
    await favoritesBox.delete(characterId);
  }
}
