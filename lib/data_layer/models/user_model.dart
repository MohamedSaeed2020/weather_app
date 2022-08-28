class UserModel {
  String? name;
  String? email;
  String? city;
  String? userId;

  UserModel({
    required this.name,
    this.email,
    required this.city,
    this.userId,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'];
      email = json['email'];
      city = json['city'];
      userId = json['userId'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
    };
  }
}
