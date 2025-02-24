import 'package:flutter/material.dart';
import 'package:pokedex/domain/utils/extensions/StringExtension.dart';
import '../domain/entities/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.capitalize(), style: TextStyle(color: Theme.of(context).colorScheme.primary),),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text('#${pokemon.id.toString().padLeft(3, '0')}', style: const TextStyle(color: Colors.grey, fontSize: 20)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl, height: 200, width: 200),
            Text('#${pokemon.id} ${pokemon.name}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}