import 'package:flutter/foundation.dart';

import '../models/driver.dart';

class FavoriteRepository {
  FavoriteRepository._internal();

  static final FavoriteRepository _instance = FavoriteRepository._internal();

  factory FavoriteRepository() => _instance;

  final ValueNotifier<Set<String>> _favoritesNotifier =
      ValueNotifier<Set<String>>(<String>{});

  ValueListenable<Set<String>> watchFavorites() => _favoritesNotifier;

  bool isFavorite(Driver driver) =>
      _favoritesNotifier.value.contains(driverKey(driver));

  bool toggleFavorite(Driver driver) {
    final key = driverKey(driver);
    final current = <String>{..._favoritesNotifier.value};

    if (current.contains(key)) {
      current.remove(key);
    } else {
      current.add(key);
    }

    _favoritesNotifier.value = current;
    return current.contains(key);
  }

  void removeFavorite(Driver driver) {
    final key = driverKey(driver);
    final current = <String>{..._favoritesNotifier.value};
    if (current.remove(key)) {
      _favoritesNotifier.value = current;
    }
  }

  String driverKey(Driver driver) => '${driver.name}|${driver.city}';
}
