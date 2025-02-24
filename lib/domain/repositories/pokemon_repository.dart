import 'package:pokedex/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> fetchPokemons();
}