import 'package:dio/dio.dart';
import 'package:primer_parcial/data/models/api_response.dart';

class AgentsService {
  final Dio dio;

  AgentsService(this.dio);

  // Hacemos llamado al path de agentes para traer todos los agentes del api
  Future<List<dynamic>> getAgents() async {
    final response = await dio.get("/agents");
    final apiResponse = ApiResponse.fromJson(response.data);
    return apiResponse.data;
  }

  // Hacemos llamado al path filtrando mediante el uuid de cada agente para traer ese agente en especifico
  Future<dynamic> getAgentById(String uuid) async {
    final response = await dio.get("/agents/$uuid");
    return response.data;
  }
}