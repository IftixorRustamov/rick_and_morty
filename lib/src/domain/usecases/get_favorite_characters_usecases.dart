import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/exceptions/database/database_exception.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_entity.dart';
import 'package:rick_and_morty/src/domain/repositories/character_repository.dart';

class GetFavoriteCharactersUsecases {
  final CharacterRepository repository;

  const GetFavoriteCharactersUsecases(this.repository);

  Future<Either<DatabaseException, List<CharacterEntity>>> call() async =>
      await repository.getFavoriteCharacters();
}
