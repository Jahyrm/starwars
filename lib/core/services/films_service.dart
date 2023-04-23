import 'package:flutter/foundation.dart';
import 'package:starwars/core/utils/api_utils.dart';
import 'package:starwars/core/settings/global_vars.dart';
import 'package:starwars/modules/home/models/film.dart';
import 'package:starwars/modules/home/models/films_response.dart';

/// Este será el repositorio de las películas de StarWars
class FilmsService {
  static List<Film> listOfFilms = [];

  /// Regresa todas las películas de StarWars desde la API.
  static Future<List<Film>?> getAllFilms({String? url}) async {
    try {
      Map<String, dynamic>? apiJsonResponse = await Api.call(
        url ?? '${GlobalVars.apiUrl}/films/',
      );

      if (apiJsonResponse != null) {
        FilmsResponse filmsResponse = FilmsResponse.fromJson(apiJsonResponse);
        if (filmsResponse.films?.isNotEmpty ?? false) {
          listOfFilms.addAll(filmsResponse.films!);
        }
        if (filmsResponse.next != null) {
          await getAllFilms(url: filmsResponse.next);
        }
        return listOfFilms;
      }
    } catch (e) {
      debugPrint(
        'Ocurrió un error al descargar la información de las películas.',
      );
    }
    return null;
  }
}
