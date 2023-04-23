import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/core/providers/favorites_provider.dart';
import 'package:starwars/core/screens/screen_base.dart';
import 'package:starwars/modules/home/widgets/character_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      leftButton: null,
      paddingMode: ScreenBasePadding.both,
      title: 'Mis Favoritos',
      wrapInScroll: false,
      child: Consumer<FavoritesProvider>(
        builder: ((context, favs, child) {
          return Column(
            children: [
              _info('Número de favoritos hombres:', favs.numMaleFavorites),
              _info('Número de favoritos mujeres:', favs.numFemaleFavorites),
              _info('Número de otros hombres:', favs.numOthersFavorites),
              _info('Número total de favoritos:', favs.myFavoritesCount),
              Expanded(
                child: ListView.builder(
                  itemCount: favs.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CharacterCard(character: favs.items[index]);
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Padding _info(String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value.toString()),
        ],
      ),
    );
  }
}
