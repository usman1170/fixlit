class ChildrenDataModel {
  late String lat;
  late String long;
  late String datetime;
  ChildrenDataModel({
    required this.lat,
    required this.long,
    required this.datetime,
  });
  ChildrenDataModel.fromJson(Map<String, dynamic> json) {
    lat = json["lat"] ?? "0.0";
    long = json["long"] ?? "0.0";
    datetime = json["date"] ?? "";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["lat"] = lat;
    data["long"] = long;
    data["date"] = datetime;
    return data;
  }
}
