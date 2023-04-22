import 'package:starwars/core/models/generic_api_response.dart';

import 'film.dart';

class FilmsResponse extends GenericApiResponse {
  List<Film>? films;

  FilmsResponse({
    int? count,
    String? next,
    String? previous,
    this.films,
  }) : super(count: count, next: next, previous: previous);

  FilmsResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      films = <Film>[];
      json['results'].forEach((v) {
        films!.add(Film.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (films != null) {
      data['results'] = films!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
