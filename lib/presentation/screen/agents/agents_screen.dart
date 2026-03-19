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
  List agents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAgents();
  }
  
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: agents.length,
      itemBuilder: (context, index) {
        final agent = agents[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => AgentDetailScreen(uuid: agent.uuid),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
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
                            maxLines: 2,
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
      final dioClient = DioClient();
      final agentsService = AgentsService(dioClient.dio);
      final agentsRepository = AgentsRepository(agentsService);

      final data  = await agentsRepository.getAgents();

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