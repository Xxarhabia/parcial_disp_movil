import 'package:dio/dio.dart';
import 'package:primer_parcial/data/models/api_response.dart';

class AgentsService {
  final Dio dio;

  AgentsService(this.dio);

  Future<List<dynamic>> getAgents() async {
    final response = await dio.get("/agents");
    final apiResponse = ApiResponse.fromJson(response.data);
    return apiResponse.data;
  }

  Future<dynamic> getAgentById(String uuid) async {
    final response = await dio.get("/agents/$uuid");
    return response.data;
  }
}