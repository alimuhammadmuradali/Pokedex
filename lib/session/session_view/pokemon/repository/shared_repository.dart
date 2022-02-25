import 'dart:async';

import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedRepository {
  SharedRepository();

  Future<bool> likePokemon(String id, Pokemon pokemon) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Pokemon> pokemons;
    final String? pokemonString = prefs.getString(id);

    if (pokemonString == null) {
      pokemons = [];
    } else {
      pokemons = Pokemon.decode(pokemonString);
    }
    var existingItem =
        pokemons.any((itemToCheck) => itemToCheck.id == pokemon.id);
    if (existingItem) {
      return false;
    } else {
      pokemons.add(pokemon);
    }
    prefs.setString(id, Pokemon.encode(pokemons));
    return true;
  }

  Future<List<Pokemon>> getFavourite(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Pokemon> pokemons;
    final String? pokemonString = prefs.getString(id);

    if (pokemonString == null) {
      pokemons = [];
    } else {
      pokemons = Pokemon.decode(pokemonString);
    }
    return pokemons;
  }

  Future<bool> unLikePokemon(String id, Pokemon pokemon) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Pokemon> pokemons;
    final String? pokemonString = prefs.getString(id);

    if (pokemonString == null) {
      pokemons = [];
    } else {
      pokemons = Pokemon.decode(pokemonString);
    }
    pokemons.removeWhere((itemToCheck) => itemToCheck.id == pokemon.id);

    prefs.setString(id, Pokemon.encode(pokemons));
    return true;
  }
}
