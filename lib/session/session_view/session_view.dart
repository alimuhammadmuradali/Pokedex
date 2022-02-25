import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/session/session_view/bloc.dart';
import 'package:pokemon/session/session_view/favourite/bloc/bloc.dart';
import 'package:pokemon/session/session_view/favourite/screen/screen.dart';
import 'package:pokemon/session/session_view/pokemon/bloc/bloc.dart';
import 'package:pokemon/session/session_view/pokemon/repository/repository.dart';
import 'package:pokemon/session/session_view/pokemon/repository/shared_repository.dart';
import 'package:pokemon/session/session_view/pokemon/screen/screen.dart';
import 'package:pokemon/session/session_view/state.dart';

class SessionView extends StatefulWidget {
  final String id;
  const SessionView({Key? key, required this.id}) : super(key: key);

  @override
  _SessionViewState createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<NavbarBloc>(context),
        builder: (BuildContext context, NavbarState state) {
          if (state is ShowFavorite) {
            return BlocProvider<FavouriteBloc>(
                create: (context) => FavouriteBloc(SharedRepository()),
                child:
                    FavouriteScreen(state.itemIndex, state.title, widget.id));
          }

          if (state is ShowPokemon) {
            return BlocProvider<PokemonBloc>(
                create: (context) => PokemonBloc(PokemonRepository()),
                child: PokemonScreen(state.itemIndex, state.title, widget.id));
          }

          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        });
  }
}
