import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/utils/app_responsive.dart';
import 'package:rick_and_morty/src/presentation/bloc/character_bloc.dart';
import 'package:rick_and_morty/src/presentation/screens/home_screen.dart';
import 'package:rick_and_morty/src/presentation/screens/splash_screen.dart';

import 'injection.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    return BlocProvider(
      create:
          (context) => CharacterBloc(
            getCharacters: dependencyContainer.getCharacters,
            getFavoriteCharacters: dependencyContainer.getFavoriteCharacters,
            addToFavorites: dependencyContainer.addToFavorites,
            removeFromFavorites: dependencyContainer.removeFromFavorites,
          ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {"home": (context) => HomeScreen()},
        home: SplashScreen(),
      ),
    );
  }
}
