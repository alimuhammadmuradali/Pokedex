import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';

abstract class LikePokemonEvent {
  const LikePokemonEvent();
}

class LikePokemons extends LikePokemonEvent {
  final String userId;
  final Pokemon pokemon;
  const LikePokemons(this.pokemon, this.userId);
}
