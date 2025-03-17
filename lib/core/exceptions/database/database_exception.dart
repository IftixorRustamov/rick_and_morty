import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class DatabaseException extends Equatable implements Exception {
  final String message;

  DatabaseException.fromHiveError(HiveError hiveError)
    : message = hiveError.message;

  @override
  List<Object?> get props => [message];
}
