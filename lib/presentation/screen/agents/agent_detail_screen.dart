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

    return SingleChildScrollView(
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
                  agent!["fullPortrait"],
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),
              Text(
                agent!["displayName"],
                style: const TextStyle(
                  fontSize: 25, 
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 8),
              Text(
                agent!["description"],
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
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
                children: (agent!["abilities"] as List).map((ability){
                  if(ability["displayName"] == null) {
                    return const SizedBox();
                  }
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: ability["displayIcon"] != null
                        ? Image.network(
                            ability["displayIcon"],
                            width: 30,
                            height: 30,
                          )
                        : const Icon(Icons.flash_on),
                      title: Text(ability["displayName"]),
                      subtitle: Text(
                        ability["description"] ?? "",
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