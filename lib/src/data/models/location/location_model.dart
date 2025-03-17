import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/src/domain/entities/characters/location_entity.dart';

part "location_model.g.dart";

@HiveType(typeId: 0)
@JsonSerializable()
class LocationModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  const LocationModel({required this.name, required this.url});

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  LocationEntity toEntity() => LocationEntity(name: name, url: url);
}
