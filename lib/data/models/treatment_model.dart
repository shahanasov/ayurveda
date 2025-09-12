class Treatment {
  final int id;
  final String name;
  int maleCount;
  int femaleCount;

  Treatment({
    required this.id,
    required this.name,
    this.maleCount = 0,
    this.femaleCount = 0,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json["id"],
      name: json['name'] ?? "Unnamed Treatment",
      maleCount: json["male_count"] ?? 0,
      femaleCount: json["female_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "male_count": maleCount,
      "female_count": femaleCount,
    };
  }
}

