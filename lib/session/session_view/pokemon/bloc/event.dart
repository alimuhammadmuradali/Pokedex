part of 'bloc.dart';

abstract class PokemonEvent {
  const PokemonEvent();
}

class GetPokemons extends PokemonEvent {
  final String userId;
  const GetPokemons(this.userId);
}
