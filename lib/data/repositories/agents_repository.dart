import 'package:primer_parcial/data/services/agents_service.dart';

class AgentsRepository {
  final AgentsService service;

  AgentsRepository(this.service);

  Future<List<dynamic>> getAgents() async {
    return await service.getAgents();
  }
}