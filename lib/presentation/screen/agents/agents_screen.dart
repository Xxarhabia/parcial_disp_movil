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

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: agent.displayIcon != null
              ? NetworkImage(agent.displayIcon!)
              : null,
            child: agent.displayIcon == null
              ? const Icon(Icons.person)
              : null,
          ),
          title: Text(agent.displayName),
          subtitle: Text(agent.description),
          onTap: () async {
            final dioClient = DioClient();
            final service = AgentsService(dioClient.dio);

            final response = await service.getAgentById(agent.uuid);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AgentDetailScreen(uuid: agent.uuid)
              ) 
            );
          },
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