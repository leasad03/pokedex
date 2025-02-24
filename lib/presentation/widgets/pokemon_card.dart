import 'package:flutter/material.dart';
import 'package:pokedex/domain/utils/extensions/StringExtension.dart';
import '../../domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Stack(
          children: [
            Positioned(
              top: 8,
              right: 8,
              child: Text('#${pokemon.id}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(pokemon.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
                Text(pokemon.name.capitalize(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}