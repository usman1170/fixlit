class ServiceProvider {
  ServiceProvider({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
    required this.catagory,
    required this.userCatagory,
  });
  late String image;
  late String name;
  late String createdAt;
  late String id;
  late String email;
  late String userCatagory;
  late String catagory;

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    catagory = json['catagory'] ?? '';
    userCatagory = json['userCatagory'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    data['catagory'] = catagory;
    data['userCatagory'] = userCatagory;
    return data;
  }
}
