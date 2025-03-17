import 'dart:developer';

import 'package:rick_and_morty/core/common/constants/url_constants.dart';
import 'package:rick_and_morty/core/network/dio_client.dart';

import '../../models/character_list/character_list_model.dart';
import 'character_remote_datasource.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final DioClient _dioClient;

  CharacterRemoteDataSourceImpl(this._dioClient);

  @override
  Future<CharacterListModel> getCharacters(int page) async {
    try {
      final response = await _dioClient.get(
        UrlConstants.character,
        queryParameters: {'page': page},
      );
      log('Response: ${response.data}');
      final model = CharacterListModel.fromJson(response.data);
      return model;
    } catch (e) {
      log('Error in CharacterRemoteDataSourceImpl: $e');
      rethrow;
    }
  }
}
