import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/core/providers/favorites_provider.dart';
import 'package:starwars/core/providers/theme_provider.dart';
import 'package:starwars/modules/home/models/character.dart';
import 'package:starwars/modules/home/widgets/film_widget.dart';

/// Widget para la visualización de un personaje.
class CharacterCard extends StatefulWidget {
  /// Este widget necesita un [Character] que contenga una lista de [films]
  final Character character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeType theme = themeProvider.themeType;

    String genero = widget.character.gender == 'male'
        ? 'Hombre'
        : (widget.character.gender == 'female' ? 'Mujer' : 'Otro');

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Películas: '),
                          const SizedBox(height: 8.0),
                          Expanded(child: _moviesList()),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/characters/${widget.character.id}.jpg'),
                        fit: BoxFit.cover),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.character.name ?? 'Nombre Desconocido',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme == ThemeType.dark
                              ? const Color(0xffcfcfcf)
                              : const Color(0xff4a4a4a),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        genero,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme == ThemeType.dark
                              ? const Color(0xffcfcfcf)
                              : const Color(0xff858585),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Consumer<FavoritesProvider>(
                    builder: (context, favs, child) {
                      return InkWell(
                        onTap: () {
                          if (favs.items
                              .where((e) => e.id == widget.character.id!)
                              .isNotEmpty) {
                            favs.remove(widget.character);
                          } else {
                            favs.add(widget.character);
                          }
                        },
                        child: Icon(
                            favs.items
                                    .where((e) => e.id == widget.character.id!)
                                    .isNotEmpty
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _moviesList() {
    if (widget.character.films?.isEmpty ?? true) {
      return const Center(
        child: Text('No ha salido en películas.'),
      );
    }
    return Center(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.character.films!.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 16);
        },
        itemBuilder: (BuildContext context, int index) {
          return FilmWidget(film: widget.character.films![index]);
        },
      ),
    );
  }
}
