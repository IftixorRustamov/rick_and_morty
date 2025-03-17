import '../../models/character_list/character_list_model.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterListModel> getCharacters(int page);
}
