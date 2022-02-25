import 'package:bloc/bloc.dart';
import 'package:pokemon/session/session_view/favourite/unlike_bloc/unlike_event.dart';
import 'package:pokemon/session/session_view/pokemon/repository/shared_repository.dart';

import 'UnLike_state.dart';

class UnLikePokemonBloc extends Bloc<UnLikePokemonEvent, UnLikePokemonState> {
  final SharedRepository _sharedRepository;

  UnLikePokemonBloc(this._sharedRepository)
      : super(const UnLikePokemonInitial()) {
    on<UnLikePokemons>(_onUnLikeEvent);
  }

  void _onUnLikeEvent(
      UnLikePokemons event, Emitter<UnLikePokemonState> emit) async {
    try {
      emit(const PokemonLiking());

      await _sharedRepository.unLikePokemon(event.userId, event.pokemon);

      emit(const PokemonUnLiked());
    } catch (e) {
      emit(
          const UnLikePokemonError('An error occured. Please try again later'));
    }
  }
}
