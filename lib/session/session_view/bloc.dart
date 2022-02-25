import 'package:bloc/bloc.dart';
import 'package:pokemon/session/session_view/event.dart';
import 'package:pokemon/session/session_view/state.dart';

class NavbarBloc extends Bloc<NavBarEvent, NavbarState> {
  NavbarBloc() : super(ShowPokemon()) {
    on<Pokemon>((event, emit) => emit(ShowPokemon()));
    on<Favorite>((event, emit) => emit(ShowFavorite()));
  }
}
