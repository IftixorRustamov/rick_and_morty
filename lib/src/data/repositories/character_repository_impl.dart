import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty/core/exceptions/database/database_exception.dart';
import 'package:rick_and_morty/core/exceptions/network/network_exception.dart';
import 'package:rick_and_morty/src/data/datasources/local/character_local_datasource.dart';
import 'package:rick_and_morty/src/data/datasources/remote/character_remote_datasource.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_entity.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_list_entity.dart';
import 'package:rick_and_morty/src/domain/repositories/character_repository.dart';

import '../models/character/character_model.dart';
import '../models/location/location_model.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;
  final CharacterLocalDataSource _localDataSource;

  CharacterRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<NetworkException, CharacterListEntity>> getCharacters(
      int page,
      ) async {
    try {
      final result = await _remoteDataSource.getCharacters(page);
      log('Fetched characters: ${result.results.length} items');
      await _localDataSource.cacheCharacters(result.results);
      log('Cached characters successfully');
      return Right(result.toEntity());
    } on DioException catch (e) {
      final networkException = NetworkException.fromDioError(e);
      log('DioException: $networkException');
      if (networkException.message.contains("internet") ||
          networkException.message.contains("timeout")) {
        final cached = await _localDataSource.getCachedCharacters();
        if (cached.isNotEmpty) {
          return Right(
            CharacterListEntity(
              count: cached.length,
              pages: 1,
              next: null,
              prev: null,
              results: cached.map((model) => model.toEntity()).toList(),
            ),
          );
        }
      }
      return Left(networkException);
    } catch (e) {
      log('Unexpected error in repository: $e');
      return Left(
        NetworkException('Unexpected error occurred: ${e.toString()}', e as int),
      );
    }
  }

  @override
  Future<Either<DatabaseException, void>> addToFavorites(
    CharacterEntity character,
  ) async {
    try {
      final model = CharacterModel(
        id: character.id,
        name: character.name,
        status: character.status,
        species: character.species,
        gender: character.gender,
        origin: LocationModel(
          name: character.origin.name,
          url: character.origin.url,
        ),
        location: LocationModel(
          name: character.location.name,
          url: character.location.url,
        ),
        image: character.image,
        isFavorite: true,
        type: character.type,
        url: character.url,
      );
      await _localDataSource.addToFavorites(model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(DatabaseException.fromHiveError(e));
    }
  }

  @override
  Future<Either<DatabaseException, List<CharacterEntity>>>
  getFavoriteCharacters() async {
    try {
      final favorites = await _localDataSource.getFavoriteCharacters();
      return Right(favorites.map((model) => model.toEntity()).toList());
    } on HiveError catch (e) {
      return Left(DatabaseException.fromHiveError(e));
    }
  }

  @override
  Future<Either<DatabaseException, void>> removeFromFavorites(
    int characterId,
  ) async {
    try {
      await _localDataSource.removeFromFavorites(characterId);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(DatabaseException.fromHiveError(e));
    }
  }
}
