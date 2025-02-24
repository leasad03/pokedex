import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/domain/entities/pokemon_details.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> fetchPokemons();
  Future<PokemonDetails> fetchPokemon(int id);
}