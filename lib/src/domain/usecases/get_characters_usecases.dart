import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/exceptions/network/network_exception.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_list_entity.dart';
import 'package:rick_and_morty/src/domain/repositories/character_repository.dart';

class GetCharactersUsecases {
  final CharacterRepository repository;

  const GetCharactersUsecases(this.repository);

  Future<Either<NetworkException, CharacterListEntity>> call(int page) async =>
      await repository.getCharacters(page);
}
