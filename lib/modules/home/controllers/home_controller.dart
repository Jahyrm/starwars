import 'package:flutter/material.dart';
import 'package:starwars/modules/home/models/character.dart';
import 'package:starwars/modules/home/models/film.dart';
import 'package:starwars/core/services/characters_service.dart';
import 'package:starwars/core/services/films_service.dart';

/// Lógica de la pantalla inicial
class HomeController {
  /// Esta variable nos dirá en que modo está la app;
  late bool isLightMode;

  /// Lista que contendrás las películas provenientes de la api.
  List<Film>? filmsList;
  List<Character>? charactersList;

  List<DropdownMenuItem<String?>> comboItems = [
    const DropdownMenuItem(child: Text('Ninguno'), value: null),
    const DropdownMenuItem(child: Text('Hombres'), value: 'male'),
    const DropdownMenuItem(child: Text('Mujeres'), value: 'female'),
    const DropdownMenuItem(child: Text('Otros'), value: 'n/a'),
  ];

  String? filtro;

  Future<List<Character>?> getCharacters({String? url}) async {
    // Primero obtenemos las películas
    filmsList = await FilmsService.getAllFilms();
    if (filmsList != null) {
      charactersList =
          await CharactersService.getAllCharacters(filmsList: filmsList);
    }
    return charactersList;
  }
}
