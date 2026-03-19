import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Mario Luis Sarabia Carrascal - 192014"),
          Text("Javier Mauricio Serna Osorio - 192546"),
        ],
      ),
    );
  }
}