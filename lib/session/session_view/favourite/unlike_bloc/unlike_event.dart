import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';

abstract class UnLikePokemonEvent {
  const UnLikePokemonEvent();
}

class UnLikePokemons extends UnLikePokemonEvent {
  final String userId;
  final Pokemon pokemon;
  const UnLikePokemons(this.pokemon, this.userId);
}
