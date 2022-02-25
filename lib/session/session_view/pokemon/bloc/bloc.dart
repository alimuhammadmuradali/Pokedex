import 'package:bloc/bloc.dart';
import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';
import 'package:pokemon/session/session_view/pokemon/repository/repository.dart';

part 'event.dart';
part 'state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;
  List<Pokemon> _pokemonList = [];

  PokemonBloc(this._pokemonRepository) : super(const PokemonInitial()) {
    on<GetPokemons>(_onGetEvent);
  }

  void _onGetEvent(GetPokemons event, Emitter<PokemonState> emit) async {
    emit(const PokemonLoading());
    try {
      emit(const PokemonLoading());
      await Future.delayed(const Duration(milliseconds: 400));
      _pokemonList = await _pokemonRepository.getPokemon();
      emit(PokemonLoaded(_pokemonList, event.userId));
    } catch (e) {
      emit(const PokemonError('An error occured. Please try again later'));
    }
  }
}
