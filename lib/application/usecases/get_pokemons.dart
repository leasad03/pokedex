import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';

class GetPokemons {
  final PokemonRepository repository;

  GetPokemons(this.repository);

  Future<List<Pokemon>> execute() {
    return repository.fetchPokemons();
  }
}