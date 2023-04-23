import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starwars/core/providers/favorites_provider.dart';
import 'package:starwars/core/providers/theme_provider.dart';
import 'package:starwars/core/screens/connection_info.dart';
import 'package:starwars/core/screens/screen_base.dart';
import 'package:starwars/core/utils/star_wars_icons.dart';
import 'package:starwars/modules/favorites/screens/favorites_screen.dart';
import 'package:starwars/modules/home/controllers/home_controller.dart';
import 'package:starwars/modules/home/models/character.dart';
import 'package:starwars/modules/home/widgets/character_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Esta será la lógica de esta pantalla
  final HomeController _con = HomeController();

  /// Future que traerá los datos desde el api.
  late Future<List<Character>?> _future;

  @override
  void initState() {
    _future = _con.getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Seteamos el modo de la app;
    _con.isLightMode =
        context.watch<ThemeProvider>().themeType == ThemeType.light;

    /// Construimos la UI dependiendo del estado de la llamada al API.
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<List<Character>?> sp) {
        if (sp.connectionState != ConnectionState.waiting) {
          if (sp.hasData) {
            if (sp.data!.isNotEmpty) {
              return _body(sp.data!);
            } else {
              return const ConnectionInfoScreen(type: ConnectionInfo.empty);
            }
          } else {
            return ConnectionInfoScreen(
              type: ConnectionInfo.error,
              customMessage: sp.error?.toString(),
            );
          }
        } else {
          return const ConnectionInfoScreen(type: ConnectionInfo.loading);
        }
      },
    );
  }

  /// Mostramos la lista de personajes
  Widget _body(List<Character> charactersList) {
    // Filtramos, en caso de que haya seleccionado un filtro.
    List<Character> finalList;
    if (_con.filtro == null) {
      finalList = charactersList;
    } else {
      finalList = charactersList
          .where((Character element) => element.gender == _con.filtro)
          .toList();
    }

    return ScreenBase(
      leftButton: IconButton(
        onPressed: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        icon: const Icon(Icons.exit_to_app),
      ),
      title: 'STAR WARS APP',
      actionButtons: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            );
          },
          icon: Stack(
            children: [
              const Icon(Icons.favorite_sharp),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Consumer<FavoritesProvider>(
                    builder: (context, favs, child) {
                      return Text(
                        '${favs.myFavoritesCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      wrapInScroll: false,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filtrar por: '),
                DropdownButton<String?>(
                  value: _con.filtro,
                  items: _con.comboItems,
                  onChanged: (String? value) {
                    setState(() {
                      _con.filtro = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: finalList.length,
              itemBuilder: (BuildContext context, int index) {
                return CharacterCard(character: finalList[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  /// Botón que cambia el tema de la app
  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        _showPopUp();
        context.read<ThemeProvider>().changeCurrentTheme();
      },
      tooltip: 'Cambiar tema',
      child: _con.isLightMode
          ? const Icon(
              StarWarsIcons.darthVader,
              color: Colors.black,
            )
          : const Icon(
              StarWarsIcons.yoda,
              color: Colors.green,
              size: 45,
            ),
    );
  }

  /// Método que muestra el popup del cambio.
  void _showPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            _con.isLightMode
                ? 'Te has cambiado al lado oscuro!'
                : 'Has vuelto al lado luminoso!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'StarJedi'),
          ),
          content: Text(
            'Qué la fuerza te acompañe!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: _con.isLightMode ? 'StarJhol' : 'StarJout'),
          ),
        );
      },
    );
  }
}
