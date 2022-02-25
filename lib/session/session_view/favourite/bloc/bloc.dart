import 'package:bloc/bloc.dart';
import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';
import 'package:pokemon/session/session_view/pokemon/repository/shared_repository.dart';

part 'event.dart';
part 'state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<Pokemon> _favouriteList = [];
  final SharedRepository _sharedRepository;

  FavouriteBloc(this._sharedRepository) : super(const FavouriteInitial()) {
    on<GetFavourites>(_onGetEvent);
  }

  void _onGetEvent(GetFavourites event, Emitter<FavouriteState> emit) async {
    emit(const FavouriteLoading());
    try {
      emit(const FavouriteLoading());
      await Future.delayed(const Duration(milliseconds: 400));
      _favouriteList = await _sharedRepository.getFavourite(event.userId);
      emit(FavouriteLoaded(_favouriteList, event.userId));
    } catch (e) {
      emit(const FavouriteError('An error occured. Please try again later'));
    }
  }
}
