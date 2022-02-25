import 'package:bloc/bloc.dart';
import 'package:pokemon/session/session_view/pokemon/repository/shared_repository.dart';

import 'like_event.dart';
import 'like_state.dart';

class LikePokemonBloc extends Bloc<LikePokemonEvent, LikePokemonState> {
  final SharedRepository _sharedRepository;

  LikePokemonBloc(this._sharedRepository) : super(const LikePokemonInitial()) {
    on<LikePokemons>(_onLikeEvent);
  }

  void _onLikeEvent(LikePokemons event, Emitter<LikePokemonState> emit) async {
    try {
      emit(const PokemonLiking());
      bool added =
          await _sharedRepository.likePokemon(event.userId, event.pokemon);
      added
          ? emit(const PokemonLiked())
          : emit(const LikePokemonError('Alreadt in Favourite List'));
    } catch (e) {
      
      emit(const LikePokemonError('An error occured. Please try again later'));
    }
  }
}
