class ServiceProvider {
  ServiceProvider({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
    required this.city,
    required this.catagory,
    required this.userCatagory,
    required this.address,
    required this.bio,
    required this.phone,
    required this.timings,
    required this.license,
    required this.available,
  });
  late String image;
  late String name;
  late String createdAt;
  late String id;
  late String email;
  late String city;
  late String userCatagory;
  late String catagory;
  late String address;
  late String bio;
  late String phone;
  late String timings;
  late String license;
  late bool available;

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    city = json['city'] ?? '';
    catagory = json['catagory'] ?? '';
    userCatagory = json['userCatagory'] ?? '';
    address = json['address'] ?? '';
    bio = json['bio'] ?? '';
    phone = json['phone'] ?? '';
    timings = json['timings'] ?? '';
    license = json['license'] ?? '';
    available = json['available'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    data['city'] = city;
    data['catagory'] = catagory;
    data['userCatagory'] = userCatagory;
    data['address'] = address;
    data['bio'] = bio;
    data['phone'] = phone;
    data['timings'] = timings;
    data['license'] = license;
    data['available'] = available;
    return data;
  }
}
