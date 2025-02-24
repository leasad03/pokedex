import 'package:pokedex/domain/entities/pokemon_details.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonDetails {
  final PokemonRepository repository;

  GetPokemonDetails(this.repository);

  Future<PokemonDetails> execute(int id) {
    return repository.fetchPokemon(id);
  }
}