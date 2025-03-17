import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/exceptions/database/database_exception.dart';
import 'package:rick_and_morty/src/domain/repositories/character_repository.dart';

import '../entities/characters/character_entity.dart';

class AddToFavoritesUsecases {
  final CharacterRepository repository;

  const AddToFavoritesUsecases(this.repository);

  Future<Either<DatabaseException, void>> call(
    CharacterEntity character,
  ) async => await repository.addToFavorites(character);
}
