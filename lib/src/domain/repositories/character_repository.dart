import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/exceptions/database/database_exception.dart';
import 'package:rick_and_morty/core/exceptions/network/network_exception.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_entity.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_list_entity.dart';

abstract class CharacterRepository {
  Future<Either<NetworkException, CharacterListEntity>> getCharacters(int page);

  Future<Either<DatabaseException, List<CharacterEntity>>>
  getFavoriteCharacters();

  Future<Either<DatabaseException, void>> addToFavorites(
    CharacterEntity character,
  );

  Future<Either<DatabaseException, void>> removeFromFavorites(int characterId);
}
