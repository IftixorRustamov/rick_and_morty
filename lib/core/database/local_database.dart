import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import '../../src/data/models/character/character_model.dart';

class LocalDatabase {
  late final HiveInterface _hive;
  late final Box<CharacterModel> _characterBox;
  late final Box<CharacterModel> _favoritesBox;
  bool _isInitialized = false;

  Box<CharacterModel> get characterBox =>
      _isInitialized
          ? _characterBox
          : throw Exception('Hive has not been initialized.');

  Box<CharacterModel> get favoritesBox =>
      _isInitialized
          ? _favoritesBox
          : throw Exception('Hive has not been initialized.');

  LocalDatabase({HiveInterface? hive}) : _hive = hive ?? Hive;

  Future<void> initialize() async {
    if (_isInitialized) {
      throw Exception('Hive has already been initialized.');
    }
    try {
      _characterBox = await _hive.openBox<CharacterModel>('characters');
      _favoritesBox = await _hive.openBox<CharacterModel>('favorites');
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize Hive: $e');
    }
  }
}
