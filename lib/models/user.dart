class UserModel {
  final String? name, email;

  const UserModel({required this.name, required this.email});

  // UserModel.fromJson(Map<String, dynamic> json)
  //   : name = json['name'],
  //     email = json['email'];

  UserModel.fromDb(Map<String, dynamic> json)
    : name = json['name'],
      email = json['email'];

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}
