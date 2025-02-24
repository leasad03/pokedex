import 'package:flutter/material.dart';

class SearchPokemon extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const SearchPokemon({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Buscar',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: onSearch,
      ),
    );
  }
}