import 'package:flutter/material.dart';
import 'package:starwars/modules/home/models/film.dart';

/// Widget para mostrar visualmente una película.
class FilmWidget extends StatelessWidget {
  /// Este widget, necesita un objeto de tipo [Film] de donde se extraerán los
  /// datos mostrados.
  final Film film;

  const FilmWidget({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2.0),
              borderRadius: BorderRadius.circular(110.0)),
          child: ClipOval(
            child: Image.asset(
              'assets/images/films/${film.id}.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 100,
          child: Text(
            film.title ?? 'Título Desconocido',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
