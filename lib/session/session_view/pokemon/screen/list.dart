import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/session/session_view/pokemon/like_bloc/like_bloc.dart';
import 'package:pokemon/session/session_view/pokemon/like_bloc/like_state.dart';
import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';
import 'package:pokemon/session/session_view/pokemon/screen/no_result.dart';
import 'package:pokemon/session/session_view/pokemon/screen/item.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({Key? key, required this.pokemonList, required this.id})
      : super(key: key);

  final List<Pokemon> pokemonList;
  final String id;

  static double mainAxisSpacing = 2;
  static double crossAxisSpacing = 2;
  static double childAspectRatio = 1.25;
  static int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    if (pokemonList.isEmpty) {
      return const NoResults(
          description: 'No pokemon found matching your search.');
    }

    return BlocListener<LikePokemonBloc, LikePokemonState>(
        listener: (context, state) {
          if (state is PokemonLiked) {
            _showDialog(context);
          }
          if (state is LikePokemonError) {
            _showErrorDialog(context);
          }
        },
        child: GridView.count(
          padding: const EdgeInsets.all(8),
          crossAxisCount: crossAxisCount,
          children: pokemonList
              .map((pokemon) => PokemonItem(
                    pokemon: pokemon,
                    userId: id,
                  ))
              .toList(),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ));
  }
}

void _showDialog(BuildContext context) {
  // ignore: avoid_single_cascade_in_expression_statements
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      title: 'Succes',
      desc: 'Pokemon Added to Favourites',
      btnOkOnPress: () {
        debugPrint('OnClcik');
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      })
    ..show();
}

void _showErrorDialog(BuildContext context) {
  // ignore: avoid_single_cascade_in_expression_statements
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      title: 'Error',
      desc: 'Already in Favourite List',
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
    ..show();
}
