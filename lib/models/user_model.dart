class UserModel {
  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.createdAt,
    required this.role,
  });
  late String name;
  late String id;
  late String email;
  late String createdAt;

  late String role;

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    id = json["id"] ?? "";
    email = json["email"] ?? "";
    createdAt = json["createdAt"] ?? "";
    role = json["role"] ?? "";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    data["email"] = email;
    data["createdAt"] = createdAt;
    data["role"] = role;
    return data;
  }
}
