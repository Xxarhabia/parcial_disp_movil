import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:primer_parcial/core/network/dio_client.dart';
import 'package:primer_parcial/data/repositories/agents_repository.dart';
import 'package:primer_parcial/data/services/agents_service.dart';
import 'package:primer_parcial/presentation/screen/agents/agent_detail_screen.dart';

class AgentsScreen extends StatefulWidget {
  const AgentsScreen({super.key});

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  //Manejo basico de estados: datos y UI
  List agents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAgents();
  }
  
  @override
  Widget build(BuildContext context) {
    //Si no hay datos no renderiza nada
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Lista dinamica: renderiza solo lo visible
    return ListView.builder(
      itemCount: agents.length,
      itemBuilder: (context, index) {
        final agent = agents[index];

        return Padding(
          //agregamos un padding simetrico tanto vertical como horizaontalmente
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), 
          child: Card(
            elevation: 6, // agrgamos sombra
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), //Agregamos bordes redondeados
            ),
            child: InkWell( //efecto visual al tocar, hace la card clickeable
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                //Realizamos la navegacion a otra pantalla pasando el UUID
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => AgentDetailScreen(uuid: agent.uuid),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                // usamos Row para poner la imagen a la izquierda y texto a la derecha
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      //validamos lo que se muestra en caso si displayIcon es null o no
                      child: agent.displayIcon != null
                        ? Image.network(
                            agent.displayIcon!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(Icons.person),
                          ),
                    ),

                    const SizedBox(width: 12),
                    // evitamos el overflow y permitimos que el texto se adapte
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            agent.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            agent.description,
                            maxLines: 2, //limitamos la cantidad de lineas para que no se vea cargado
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> loadAgents() async {
    try {
      //Realizamos la carga de datos con aquitectura en capas (dio, service, repository)
      final dioClient = DioClient();
      final agentsService = AgentsService(dioClient.dio);
      final agentsRepository = AgentsRepository(agentsService);

      // Llamada asincrona a la API
      final data  = await agentsRepository.getAgents();

      // Actualizamos la UI y disparamos un rebuild
      setState(() {
        agents = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = true;
      });
    }
  }
}