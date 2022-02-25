import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/session/session_view/favourite/bloc/bloc.dart';
import 'package:pokemon/session/session_view/favourite/screen/item.dart';
import 'package:pokemon/session/session_view/favourite/unlike_bloc/UnLike_state.dart';
import 'package:pokemon/session/session_view/favourite/unlike_bloc/unlike_bloc.dart';
import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';
import 'package:pokemon/session/session_view/favourite/screen/no_result.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({Key? key, required this.favouriteList, required this.id})
      : super(key: key);

  final List<Pokemon> favouriteList;
  final String id;

  static double mainAxisSpacing = 2;
  static double crossAxisSpacing = 2;
  static double childAspectRatio = 1.25;
  static int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    if (favouriteList.isEmpty) {
      return const NoResults(description: 'No favourite found');
    }

    return BlocListener<UnLikePokemonBloc, UnLikePokemonState>(
        listener: (context, state) {
          if (state is PokemonUnLiked) {
            _showDialog(context, id);
          }
        },
        child: GridView.count(
          padding: const EdgeInsets.all(8),
          crossAxisCount: crossAxisCount,
          children: favouriteList
              .map((favourite) => FavouriteItem(
                    favourite: favourite,
                    userId: id,
                  ))
              .toList(),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ));
  }
}

void _showDialog(BuildContext context, String id) {
  // ignore: avoid_single_cascade_in_expression_statements
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      title: 'Succes',
      desc: 'Pokemon Removed from Favourites',
      btnOkOnPress: () {
        BlocProvider.of<FavouriteBloc>(context).add(GetFavourites(id));
        debugPrint('OnClcik');
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        BlocProvider.of<FavouriteBloc>(context).add(GetFavourites(id));
        debugPrint('Dialog Dissmiss from callback $type');
      })
    ..show();
}
