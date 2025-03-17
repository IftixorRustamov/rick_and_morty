import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/src/domain/entities/characters/location_entity.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationEntity origin;
  final LocationEntity location;
  final String image;
  final String url;
  final bool isFavorite;

  const CharacterEntity({
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
    required this.isFavorite,
  });

  @override
  List<Object> get props => [
    id,
    name,
    status,
    species,
    type,
    gender,
    origin,
    location,
    image,
    url,
    isFavorite,
  ];
}
