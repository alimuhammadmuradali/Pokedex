part of 'bloc.dart';

abstract class PokemonState {
  const PokemonState();
}

class PokemonInitial extends PokemonState {
  const PokemonInitial();
}

class PokemonLoading extends PokemonState {
  const PokemonLoading();
}

class PokemonLoaded extends PokemonState {
  final String userId;
  final List<Pokemon> pokemonList;

  const PokemonLoaded(this.pokemonList, this.userId);
}

class PokemonError extends PokemonState {
  final String message;
  const PokemonError(this.message);
}
