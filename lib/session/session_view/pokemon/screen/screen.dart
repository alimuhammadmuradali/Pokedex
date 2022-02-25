import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/session/cubit/session_cubit.dart';
import 'package:pokemon/session/session_view/bloc.dart';
import 'package:pokemon/session/session_view/event.dart';
import 'package:pokemon/session/session_view/pokemon/bloc/bloc.dart';
import 'package:pokemon/session/session_view/pokemon/like_bloc/like_bloc.dart';
import 'package:pokemon/session/session_view/pokemon/repository/shared_repository.dart';
import 'package:pokemon/session/session_view/pokemon/screen/no_result.dart';
import 'package:pokemon/session/session_view/pokemon/screen/list.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class PokemonScreen extends StatefulWidget {
  final int currentIndex;
  final String title;
  final String id;
  const PokemonScreen(this.currentIndex, this.title, this.id, {Key? key})
      : super(key: key);
  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context).add(GetPokemons(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder(
        builder: (context, state) {
          if (state is PokemonLoaded) {
            return BlocProvider<LikePokemonBloc>(
                create: (context) => LikePokemonBloc(SharedRepository()),
                child: PokemonList(
                  pokemonList: state.pokemonList,
                  id: state.userId,
                ));
          } else if (state is PokemonLoading) {
            return Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Image.asset(
                  'asset/pokiLogo.png',
                  width: 100,
                  height: 100,
                ),
              ),
            );
          } else if (state is PokemonError) {
            return const NoResults(description: 'Error fetching Pokemon');
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }
        },
        bloc: BlocProvider.of<PokemonBloc>(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red.shade100,
        // selectedItemColor: Colors.white,
        // selectedLabelStyle: TextStyle(color: Colors.white),
        currentIndex: widget.currentIndex,
        onTap: (index) {
          if (index == 0) {
            BlocProvider.of<NavbarBloc>(context).add(Pokemon());
          }
          if (index == 1) {
            BlocProvider.of<NavbarBloc>(context).add(Favorite());
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: "Pokemon",
              activeIcon: Icon(Icons.person)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: "Favourite"),
        ],
      ),
    );
  }
}
