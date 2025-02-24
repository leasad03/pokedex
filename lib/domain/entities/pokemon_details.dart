import 'package:pokedex/domain/entities/stat.dart';

class PokemonDetails {
  final String name;
  final String imageUrl;
  final List<String> types;
  final double height;
  final double weight;
  final String description;
  final List<Stat> stats;

  PokemonDetails({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.description,
    required this.stats,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> data, Map<String, dynamic> speciesData) {
    final description = speciesData['flavor_text_entries']
        .firstWhere((entry) => entry['language']['name'] == 'en')['flavor_text']
        .replaceAll('\n', ' ')
        .replaceAll('\f', ' ');

    return PokemonDetails(
      name: data['name'],
      imageUrl: data['sprites']['front_default'],
      types: List<String>.from(data['types'].map((type) => type['type']['name'])),
      height: data['height'] / 10.0,
      weight: data['weight'] / 10.0,
      description: description,
      stats: (data['stats'] as List)
          .map((stat) => Stat(
          statName: stat['stat']['name'],
          value: stat['base_stat']))
          .toList(),
    );
  }
}