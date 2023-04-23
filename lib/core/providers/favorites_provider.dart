import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:starwars/core/preferences/favs_preferences.dart';
import 'package:starwars/modules/home/models/character.dart';

class FavoritesProvider extends ChangeNotifier {
  /// Preferencias de los favoritos
  FavoritesPreferences favoritesPreferences = FavoritesPreferences();

  /// Internal, private state of the favorites model.
  final List<Character> _favoritesIds = [];

  /// An unmodifiable view of the items in favorites.
  UnmodifiableListView<Character> get items =>
      UnmodifiableListView(_favoritesIds);

  /// The current number of items in favorites
  int get myFavoritesCount => _favoritesIds.length;

  /// The current number of male characters in favorites
  int get numMaleFavorites =>
      _favoritesIds.where((Character e) => e.gender == 'male').length;

  /// The current number of female characters in favorites
  int get numFemaleFavorites =>
      _favoritesIds.where((Character e) => e.gender == 'female').length;

  /// The current number of others characters in favorites
  int get numOthersFavorites =>
      _favoritesIds.where((Character e) => e.gender == 'n/a').length;

  bool contains(Character id) {
    return _favoritesIds.contains(id);
  }

  /// We fecth the actual favorites
  FavoritesProvider() {
    setInitialFavorites();
  }

  setInitialFavorites() {
    favoritesPreferences.getValue().then((value) {
      if (value != null) {
        List<dynamic> savedIds = jsonDecode(value);
        if (savedIds.isNotEmpty) {
          for (dynamic i in savedIds) {
            add(Character.fromJson(i));
          }
        }
      }
    });
  }

  /// Adds [id] to favorites. This, [remove] and [removeAll] are the only ways
  /// to modify the favorites from the outside.
  void add(Character item) {
    _favoritesIds.add(item);
    favoritesPreferences.setValue(jsonEncode(_favoritesIds));
    notifyListeners();
  }

  /// Remove an item from favorites
  void remove(Character item) {
    _favoritesIds.removeWhere(((element) => element.id == item.id));
    favoritesPreferences.setValue(jsonEncode(_favoritesIds));
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from favorites.
  void removeAll() {
    _favoritesIds.clear();
    favoritesPreferences.setValue(jsonEncode(_favoritesIds));
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
