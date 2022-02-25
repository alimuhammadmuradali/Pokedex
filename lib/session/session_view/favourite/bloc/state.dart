part of 'bloc.dart';

abstract class FavouriteState {
  const FavouriteState();
}

class FavouriteInitial extends FavouriteState {
  const FavouriteInitial();
}

class FavouriteLoading extends FavouriteState {
  const FavouriteLoading();
}

class FavouriteLoaded extends FavouriteState {
  final String userId;
  final List<Pokemon> favouriteList;

  const FavouriteLoaded(this.favouriteList, this.userId);
}

class FavouriteError extends FavouriteState {
  final String message;
  const FavouriteError(this.message);
}
