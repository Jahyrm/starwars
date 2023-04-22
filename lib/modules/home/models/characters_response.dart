import 'package:starwars/core/models/generic_api_response.dart';
import 'package:starwars/modules/home/models/character.dart';

import 'film.dart';

class CharactersResponse extends GenericApiResponse {
  List<Character>? characters;

  CharactersResponse({
    int? count,
    String? next,
    String? previous,
    this.characters,
  }) : super(count: count, next: next, previous: previous);

  CharactersResponse.fromJson(Map<String, dynamic> json,
      {List<Film>? filmsList}) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      characters = <Character>[];
      json['results'].forEach((v) {
        characters!.add(Character.fromJson(v, filmsList: filmsList));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (characters != null) {
      data['results'] = characters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
