import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonApi implements PokemonRepository {
  @override
  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).asMap().entries.map((entry) {
        int id = entry.key + 1;
        return Pokemon(
          id: id,
          name: entry.value['name'],
          imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png',
        );
      }).toList();
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}