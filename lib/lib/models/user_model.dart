class UserModel {
  final String id;
  final String name;
  final String studyLevel;
  final int preferredSessionMinutes;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.studyLevel,
    required this.preferredSessionMinutes,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      studyLevel: json['study_level'],
      preferredSessionMinutes: json['preferred_session_minutes'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'study_level': studyLevel,
      'preferred_session_minutes': preferredSessionMinutes,
    };
  }
}
