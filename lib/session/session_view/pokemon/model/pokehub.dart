import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';

class PokeHub {
  List<Pokemon> pokemon = [];

  PokeHub({required this.pokemon});

  PokeHub.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      pokemon = [];
      json['results'].forEach((v) {
        pokemon.add(Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pokemon'] = pokemon.map((v) => v.tojson()).toList();
    return data;
  }
}
