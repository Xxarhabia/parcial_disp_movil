import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:primer_parcial/core/network/dio_client.dart';
import 'package:primer_parcial/data/services/agents_service.dart';

class AgentDetailScreen extends StatefulWidget {
  final String uuid; //recibimos el UUID desde la pantalla anterior definiendo que agentes cargar

  const AgentDetailScreen({super.key, required this.uuid});

  @override
  State<AgentDetailScreen> createState() => _AgentDetailScreenState();
}

class _AgentDetailScreenState extends State<AgentDetailScreen> {
  // Manejo del estado (datos de agente y estado de carga)
  Map? agent;
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    loadAgent();
  }

  Future<void> loadAgent() async {
    final dioClient = DioClient();
    final service = AgentsService(dioClient.dio);
    //consumo del API usando el UUID recibido
    final response = await service.getAgentById(widget.uuid);

    // guardamos los datos del agente devueltos por el API   
    setState(() {
      agent = response["data"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Evitamos renderizar sin datos
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView( //permitimos el scroll vertical, necesario por el uso de imagen, texto y habilidades
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  agent!["fullPortrait"], //llamamos la propiedad del agente
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),
              Text(
                agent!["displayName"], //llamamos la propiedad del agente
                style: const TextStyle(
                  fontSize: 25, 
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 8),
              Text(
                agent!["description"], //llamamos la propiedad del agente
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft, //Alinemaos titulo a la izquierda rompiendo centrado anterior: mejor lectura
                child: Text(
                  "Habilidades",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Column(
                // Tomamos la lista del JSON transformadola en widgets
                children: (agent!["abilities"] as List).map((ability){
                  // Evitamos mostrar habilidades vacias
                  if(ability["displayName"] == null) {
                    return const SizedBox();
                  }
                  // definimos un Card por cada habilidad
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      // definimos si el displayIcon es null o no mostrando iconos dependiendo la validacion
                      leading: ability["displayIcon"] != null
                        ? Image.network(
                            ability["displayIcon"],
                            width: 30,
                            height: 30,
                          )
                        : const Icon(Icons.flash_on),
                      title: Text(ability["displayName"]),
                      subtitle: Text(
                        ability["description"] ?? "", //en caso de la descripcion ser null muestra vacio
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}