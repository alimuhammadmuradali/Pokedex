abstract class NavbarState {}

class ShowPokemon extends NavbarState {
  final String title = "Pokemon";
  final int itemIndex = 0;

  ShowPokemon();
}

class ShowFavorite extends NavbarState {
  final String title = "Favourite";
  final int itemIndex = 1;
  ShowFavorite();
}
