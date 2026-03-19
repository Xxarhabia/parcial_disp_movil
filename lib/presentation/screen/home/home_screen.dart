import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Hace que el fondo ocupe todo el espacio disponible
      decoration: const BoxDecoration(
        gradient: LinearGradient( // Aplica el fondo degradado
          colors: [
            Color(0xFF0F1923),
            Color(0XFF1F2A38)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          //Define la direccion del degadado de arriba hacia abajo
        ),
      ),
      child: Center(
        //centramos todo el contenido en pantalla
        child: Card(
          elevation: 10, //sombra efecto flotante
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20), //bordes redondeados
          ),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min, // hace que la card se ajuste al contenido
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
                const Divider(height: 30), // linea separadora + espacio vertical
                //reutilizadcion de UI
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