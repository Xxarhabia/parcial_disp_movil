import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F1923),
            Color(0XFF1F2A38)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Integrantes",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Divider(height: 30),
                _buildPerson("Mario Luis Sarabia Carrascal", "192014"),
                const SizedBox(height: 10),
                _buildPerson("Javier Mauricio Serna Osorio", "192546")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPerson(String name, String code) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 10, color: Colors.redAccent),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          code,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        )
      ],
    );
  }
}