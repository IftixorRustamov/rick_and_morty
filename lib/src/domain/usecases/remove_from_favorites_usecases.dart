import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/exceptions/database/database_exception.dart';
import 'package:rick_and_morty/src/domain/repositories/character_repository.dart';

class RemoveFromFavoritesUsecases {
  final CharacterRepository repository;

  const RemoveFromFavoritesUsecases(this.repository);

  Future<Either<DatabaseException, void>> call(int characterId) async =>
      await repository.removeFromFavorites(characterId);
}
