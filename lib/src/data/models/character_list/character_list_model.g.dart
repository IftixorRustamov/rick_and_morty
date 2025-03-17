// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterListModel _$CharacterListModelFromJson(Map<String, dynamic> json) =>
    CharacterListModel(
      info: InfoModel.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharacterListModelToJson(CharacterListModel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => InfoModel(
      count: (json['count'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );

Map<String, dynamic> _$InfoModelToJson(InfoModel instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
