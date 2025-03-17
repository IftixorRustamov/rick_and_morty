import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/src/data/models/character/character_model.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_list_entity.dart';

part 'character_list_model.g.dart';

@JsonSerializable()
class CharacterListModel {
  @JsonKey(name: 'info')
  final InfoModel info;
  final List<CharacterModel> results;

  const CharacterListModel({
    required this.info,
    required this.results,
  });

  factory CharacterListModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterListModelToJson(this);

  CharacterListEntity toEntity() => CharacterListEntity(
    count: info.count,
    pages: info.pages,
    next: info.next,
    prev: info.prev,
    results: results.map((model) => model.toEntity()).toList(),
  );
}

@JsonSerializable()
class InfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const InfoModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}