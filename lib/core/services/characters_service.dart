import 'package:flutter/foundation.dart';
import 'package:starwars/core/utils/api_utils.dart';
import 'package:starwars/core/settings/global_vars.dart';
import 'package:starwars/modules/home/models/character.dart';
import 'package:starwars/modules/home/models/characters_response.dart';
import 'package:starwars/modules/home/models/film.dart';

/// Este será el repositorio de los personajes de StarWars
class CharactersService {
  static List<Character> listOfCharacters = [];

  /// Regresa todos los personajes de StarWars desde la API.
  static Future<List<Character>?> getAllCharacters({
    String? url,
    List<Film>? filmsList,
  }) async {
    try {
      // Hacemos la llamada a la api para cargar las películas
      Map<String, dynamic>? apiJsonResponse = await Api.call(
        url ?? '${GlobalVars.apiUrl}/people/',
      );

      if (apiJsonResponse != null) {
        CharactersResponse charactersResponse = CharactersResponse.fromJson(
          apiJsonResponse,
          filmsList: filmsList,
        );
        if (charactersResponse.characters?.isNotEmpty ?? false) {
          listOfCharacters.addAll(charactersResponse.characters!);
        }
        if (charactersResponse.next != null) {
          await getAllCharacters(
            url: charactersResponse.next,
            filmsList: filmsList,
          );
        }
        return listOfCharacters;
      }
    } catch (e) {
      debugPrint(
        'Ocurrió un error al descargar la información de las películas.',
      );
    }
    return null;
  }
}
