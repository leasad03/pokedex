import 'package:flutter/material.dart';
import '../domain/entities/pokemon.dart';
import '../infrastructure/datasources/pokemon_api.dart';
import '../application/usecases/get_pokemons.dart';
import 'pokemon_detail_screen.dart';
import 'widgets/pokemon_card.dart';
import 'widgets/search_pokemon.dart';
import 'widgets/screen_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Pokemon>> futurePokemons;
  final GetPokemons getPokemons = GetPokemons(PokemonApi());

  List<Pokemon> allPokemons = [];
  List<Pokemon> filteredPokemons = [];

  @override
  void initState() {
    super.initState();
    futurePokemons = getPokemons.execute().then((pokemons) {
      setState(() {
        allPokemons = pokemons;
        filteredPokemons = pokemons; // Initially, show all Pokémon
      });
      return pokemons; // Ensure futurePokemons completes correctly
    });
  }

  void _filterPokemons(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPokemons = allPokemons;
      } else {
        filteredPokemons = allPokemons
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "¡Hola, ",
                          style: TextStyle(fontSize: 20, decoration: TextDecoration.none),
                        ),
                        TextSpan(
                            text: "bienvenido!",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                        )
                      ]
                  )
              ),
            ),
          ),
          SearchPokemon(onSearch: _filterPokemons),
          Expanded(
            child: FutureBuilder<List<Pokemon>>(
              future: futurePokemons,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (filteredPokemons.isEmpty) {
                  return const Center(child: Text("No Pokémon found"));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: filteredPokemons.length,
                  itemBuilder: (context, index) {
                    return PokemonCard(
                      pokemon: filteredPokemons[index],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PokemonDetailScreen(pokemon: filteredPokemons[index]),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}