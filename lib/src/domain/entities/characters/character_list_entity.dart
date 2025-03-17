import 'package:equatable/equatable.dart';

import 'character_entity.dart';

class CharacterListEntity extends Equatable {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  final List<CharacterEntity> results;

  const CharacterListEntity({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
    required this.results,
  });

  @override
  List<Object?> get props => [count, pages, next, prev, results];
}
