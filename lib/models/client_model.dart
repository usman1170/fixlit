class ClientModel {
  ClientModel({
    required this.name,
    required this.id,
    required this.email,
    required this.createdAt,
    required this.image,
  });
  late String name;
  late String id;
  late String email;
  late String createdAt;
  late String image;

  ClientModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    id = json["id"] ?? "";
    email = json["email"] ?? "";
    createdAt = json["createdAt"] ?? "";
    image = json["image"] ?? "";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    data["email"] = email;
    data["createdAt"] = createdAt;
    data["image"] = image;
    return data;
  }
}
