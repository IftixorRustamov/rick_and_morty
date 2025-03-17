import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty/src/data/models/character/character_model.dart';
import 'package:rick_and_morty/src/data/models/location/location_model.dart';
import 'package:rick_and_morty/src/injection.dart';
import 'package:rick_and_morty/src/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  Hive.registerAdapter(LocationModelAdapter());
  await dependencyContainer.initialize();
  runApp(MyApp());
}
