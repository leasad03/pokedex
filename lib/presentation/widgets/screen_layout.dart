import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final Widget child;

  const ScreenLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Pokedex",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF005FFF),
          ),
        ),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.catching_pokemon,
            color: Color(0xFF005FFF), // Change icon color
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: child,
      ),
    );
  }
}