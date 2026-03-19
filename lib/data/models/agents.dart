class Agents {
  final String displayName;
  final String description;
  final String displayIcon;

  Agents({
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  factory Agents.fromJson(Map<String, dynamic> json) {
    return Agents(
      displayName: json["displayName"], 
      description: json["description"],
      displayIcon: json["displayIcon"]
    );
  }
}