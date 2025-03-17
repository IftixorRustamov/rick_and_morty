import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/src/data/models/location/location_model.dart';
import 'package:rick_and_morty/src/domain/entities/characters/character_entity.dart';

part 'character_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CharacterModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String status;
  @HiveField(3)
  final String species;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final LocationModel origin;
  @HiveField(7)
  final LocationModel location;
  @HiveField(8)
  final String image;
  @HiveField(9)
  final String url;
  @HiveField(10)
  final bool isFavorite;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.url,
    this.isFavorite = false,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  CharacterModel copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    LocationModel? origin,
    LocationModel? location,
    String? image,
    String? url,
    bool? isFavorite,
  }) => CharacterModel(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    species: species ?? this.species,
    type: type ?? this.type,
    gender: gender ?? this.gender,
    origin: origin ?? this.origin,
    location: location ?? this.location,
    image: image ?? this.image,
    url: url ?? this.url,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  CharacterEntity toEntity() => CharacterEntity(
    id: id,
    name: name,
    status: status,
    species: species,
    type: type,
    gender: gender,
    origin: origin.toEntity(),
    location: location.toEntity(),
    image: image,
    url: url,
    isFavorite: isFavorite,
  );
}
