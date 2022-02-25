part of 'bloc.dart';

abstract class FavouriteEvent {
  const FavouriteEvent();
}

class GetFavourites extends FavouriteEvent {
  final String userId;
  const GetFavourites(this.userId);
}
