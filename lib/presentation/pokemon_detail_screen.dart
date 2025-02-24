import 'package:flutter/material.dart';
import 'package:pokedex/application/usecases/get_pokemon_details.dart';
import 'package:pokedex/domain/entities/pokemon_details.dart';
import 'package:pokedex/domain/utils/extensions/StringExtension.dart';
import 'package:pokedex/infrastructure/datasources/pokemon_api.dart';
import 'package:pokedex/presentation/widgets/pokemon_stats.dart';
import '../domain/entities/pokemon.dart';

import '../domain/entities/stat.dart';

class PokemonDetailScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetailScreen> {
  late Future<PokemonDetails> futurePokemon;
  final GetPokemonDetails getPokemonDetails = GetPokemonDetails(PokemonApi());
  late PokemonDetails pokeDetails;


  @override
  void initState() {
    super.initState();
    futurePokemon = getPokemonDetails.execute(widget.pokemon.id).then((pokemon) {
      setState(() {
        pokeDetails = pokemon;
      });
      return pokemon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name.capitalize(), style: TextStyle(color: Theme.of(context).colorScheme.primary),),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text('#${widget.pokemon.id.toString().padLeft(3, '0')}', style: const TextStyle(color: Colors.grey, fontSize: 20)),
          ),
        ],
      ),
      body: FutureBuilder<PokemonDetails>(
          future: futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Column(
              children: [
                Image.network(pokeDetails.imageUrl, height: 180, width: 180, fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    'Height: ${pokeDetails.height}m | Weight: ${pokeDetails.weight}kg',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 35),
                  child: Text(
                    pokeDetails.description,
                    style: TextStyle(fontSize: 16, color: Color(0xFF7C7C7C)),
                  ),
                ),
                Container(
                  height: 200,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: PokemonStatsChart(stats: pokeDetails.stats),
                ),
              ],
            );
          }
      )
    );
  }
}