class SubjectModel {
  final String id;
  final String userId;
  final String name;
  final String colorHex;

  SubjectModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.colorHex,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      colorHex: json['color_hex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'color_hex': colorHex,
    };
  }
}
