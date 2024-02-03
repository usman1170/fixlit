class JrUser {
  JrUser({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.lat,
    required this.id,
    required this.email,
    required this.long,
  });
  late String image;
  late String name;
  late String createdAt;
  late String id;
  late String email;
  late String lat;
  late String long;

  JrUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    lat = json['lat'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    long = json['long'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['lat'] = lat;
    data['id'] = id;
    data['email'] = email;
    data['long'] = long;
    return data;
  }
}
