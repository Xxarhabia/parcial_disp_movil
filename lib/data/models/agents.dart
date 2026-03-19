class Agents {
  final String uuid;
  final String displayName;
  final String description;
  final String displayIcon;

  Agents({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  factory Agents.fromJson(Map<String, dynamic> json) {
    return Agents(
      uuid: json["uuid"],
      displayName: json["displayName"], 
      description: json["description"],
      displayIcon: json["displayIcon"]
    );
  }
}