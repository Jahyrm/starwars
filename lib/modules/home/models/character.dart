import 'package:starwars/modules/home/models/film.dart';

class Character {
  String? id;
  String? name;
  String? gender;
  List<Film>? films;

  Character({
    this.id,
    this.name,
    this.gender,
    this.films,
  });

  Character.fromJson(Map<String, dynamic> json, {List<Film>? filmsList}) {
    id = json['id'] ??
        json['url']?.split('/')[json['url'].split('/').length - 2];
    name = json['name'];
    gender = json['gender'];
    if (json['films']?.isNotEmpty ?? false) {
      films = <Film>[];
      json['films'].forEach((dynamic variable) {
        if (variable is String && (filmsList?.isNotEmpty ?? false)) {
          try {
            String idBuscado =
                variable.split('/')[variable.split('/').length - 2];
            Film? film =
                filmsList!.where((Film film) => film.id == idBuscado).first;
            films!.add(film);
          } catch (e) {
            // do nothing
          }
        } else {
          films!.add(Film.fromJson(variable));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    if (films != null) {
      data['films'] = films!.map((v) => v is String ? v : v.toJson()).toList();
    }
    return data;
  }
}
