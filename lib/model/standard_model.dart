class StandardModel {
  final int id;
  final String name;
  final String status;
  final String created_at;
  final String updated_at;

  StandardModel({
    required this.id,
    required this.name,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory StandardModel.fromJson(Map<String, dynamic> json) {
    return StandardModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
