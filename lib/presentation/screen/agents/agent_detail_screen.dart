import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:primer_parcial/core/network/dio_client.dart';
import 'package:primer_parcial/data/services/agents_service.dart';

class AgentDetailScreen extends StatefulWidget {
  final String uuid;

  const AgentDetailScreen({super.key, required this.uuid});

  @override
  State<AgentDetailScreen> createState() => _AgentDetailScreenState();
}

class _AgentDetailScreenState extends State<AgentDetailScreen> {
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

    final response = await service.getAgentById(widget.uuid);

    setState(() {
      agent = response["data"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Image.network(agent!["fullPortrait"]),
        Text(
          agent!["displayName"],
          style: const TextStyle(fontSize: 30),
        ),
        Text(agent!["description"])
      ],
    );
  }
}