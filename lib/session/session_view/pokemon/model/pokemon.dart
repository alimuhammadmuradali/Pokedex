import 'dart:convert';

class Pokemon {
  late int id;
  late String name;
  late String img;

  Pokemon({
    required this.id,
    required this.name,
    required this.img,
  });

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['url'].split('/')[6]);
    name = json['name'];
    img =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  Pokemon.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
  }

  static Map<String, dynamic> toJson(Pokemon pokemon) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = pokemon.id;
    data['name'] = pokemon.name;
    data['img'] = pokemon.img;

    return data;
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;

    return data;
  }

  static String encode(List<Pokemon> pokemons) => json.encode(
        pokemons
            .map<Map<String, dynamic>>((pokemon) => Pokemon.toJson(pokemon))
            .toList(),
      );

  static List<Pokemon> decode(String pokemons) {
    return (json.decode(pokemons) as List<dynamic>).map<Pokemon>((pokemon) {
      return Pokemon.fromjson(pokemon);
    }).toList();
  }
}
