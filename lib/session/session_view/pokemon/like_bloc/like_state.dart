abstract class LikePokemonState {
  const LikePokemonState();
}

class PokemonLiking extends LikePokemonState {
  const PokemonLiking();
}

class LikePokemonInitial extends LikePokemonState {
  const LikePokemonInitial();
}

class PokemonLiked extends LikePokemonState {
  const PokemonLiked();
}

class LikePokemonError extends LikePokemonState {
  final String message;
  const LikePokemonError(this.message);
}
