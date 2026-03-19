import 'package:primer_parcial/data/models/agents.dart';

class ApiResponse {
  final int status;
  final List<Agents> data;

  ApiResponse({
    required this.status,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json["status"], 
      data: (json["data"] as List)
        .map((e) => Agents.fromJson(e))
        .toList(),
    );
  }
}