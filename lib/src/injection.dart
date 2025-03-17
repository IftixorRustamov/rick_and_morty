import 'package:rick_and_morty/core/database/local_database.dart';
import 'package:rick_and_morty/core/network/dio_client.dart';
import 'package:rick_and_morty/src/data/datasources/local/character_local_datasource.dart';
import 'package:rick_and_morty/src/data/datasources/local/character_local_datasource_impl.dart';
import 'package:rick_and_morty/src/data/datasources/remote/character_remote_datasource.dart';
import 'package:rick_and_morty/src/data/datasources/remote/character_remote_datasource_impl.dart';
import 'package:rick_and_morty/src/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty/src/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/src/domain/usecases/add_to_favorites_usecases.dart';
import 'package:rick_and_morty/src/domain/usecases/get_characters_usecases.dart';
import 'package:rick_and_morty/src/domain/usecases/get_favorite_characters_usecases.dart';
import 'package:rick_and_morty/src/domain/usecases/remove_from_favorites_usecases.dart';

class DependencyContainer {
  static final DependencyContainer _instance = DependencyContainer._internal();

  factory DependencyContainer() => _instance;

  DependencyContainer._internal();

  late final DioClient _dioClient;
  late final LocalDatabase _localDatabase;
  late final CharacterRemoteDataSource _remoteDataSource;
  late final CharacterLocalDataSource _localDataSource;
  late final CharacterRepository _repository;
  late final GetCharactersUsecases getCharacters;
  late final GetFavoriteCharactersUsecases getFavoriteCharacters;
  late final AddToFavoritesUsecases addToFavorites;
  late final RemoveFromFavoritesUsecases removeFromFavorites;

  Future<void> initialize() async {
    _dioClient = DioClient();
    _localDatabase = LocalDatabase();
    await _localDatabase.initialize();
    _remoteDataSource = CharacterRemoteDataSourceImpl(_dioClient);
    _localDataSource = CharacterLocalDataSourceImpl(
      characterBox: _localDatabase.characterBox,
      favoritesBox: _localDatabase.favoritesBox,
    );
    _repository = CharacterRepositoryImpl(_remoteDataSource, _localDataSource);
    getCharacters = GetCharactersUsecases(_repository);
    getFavoriteCharacters = GetFavoriteCharactersUsecases(_repository);
    addToFavorites = AddToFavoritesUsecases(_repository);
    removeFromFavorites = RemoveFromFavoritesUsecases(_repository);
  }
}

// Singleton instance
final dependencyContainer = DependencyContainer();
