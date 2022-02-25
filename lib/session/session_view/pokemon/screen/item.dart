import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/session/session_view/pokemon/like_bloc/like_bloc.dart';
import 'package:pokemon/session/session_view/pokemon/like_bloc/like_event.dart';
import 'package:pokemon/session/session_view/pokemon/model/pokemon.dart';
import 'package:pokemon/session/session_view/pokemon/screen/list.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key, required this.pokemon, required this.userId})
      : super(key: key);

  final Pokemon pokemon;
  final String userId;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 2;
    double itemHeight = itemWidth / PokemonList.childAspectRatio;
    double imageSize = itemHeight / 1.9;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2.0,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 23.0,
                    child: Text(pokemon.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '#${pokemon.id}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CachedNetworkImage(
                      imageUrl: pokemon.img,
                      imageBuilder: (context, imageProvider) => Container(
                        height: imageSize,
                        width: imageSize,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        height: imageSize,
                        width: imageSize,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).indicatorColor,
                            strokeWidth: 2.4,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                        child: const Icon(Icons.favorite_border),
                        onTap: () {
                          BlocProvider.of<LikePokemonBloc>(context)
                              .add(LikePokemons(pokemon, userId));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
