abstract class UnLikePokemonState {
  const UnLikePokemonState();
}

class PokemonLiking extends UnLikePokemonState {
  const PokemonLiking();
}

class UnLikePokemonInitial extends UnLikePokemonState {
  const UnLikePokemonInitial();
}

class PokemonUnLiked extends UnLikePokemonState {
  const PokemonUnLiked();
}

class UnLikePokemonError extends UnLikePokemonState {
  final String message;
  const UnLikePokemonError(this.message);
}
