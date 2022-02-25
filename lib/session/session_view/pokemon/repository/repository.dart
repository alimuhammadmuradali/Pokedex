import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pokemon/session/session_view/pokemon/model/pokehub.dart';
import 'dart:async';

import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';

class PokemonRepository {
  PokemonRepository();

  Future<List<Pokemon>> getPokemon() async {
    var response = await http
        .get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=250"));
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      PokeHub pokeHub = PokeHub.fromJson(jsonResponse);
      return pokeHub.pokemon;
    }
    throw Exception("Unabble to fetch data");
  }
}
