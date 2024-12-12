class Task {
  final String name;
  final String description;
  final int percentage;
  final String status;

  Task({
    required this.name,
    required this.description,
    required this.percentage,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      percentage: json['percentage'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'percentage': percentage,
      'status': status,
    };
  }
}
