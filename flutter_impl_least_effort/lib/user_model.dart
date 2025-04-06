class UserModel {
  final String id;
  final String name;
  final String email;
  final String gender;
  final String birthday;
  final bool emailUpdates;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.emailUpdates,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      birthday: json['birthday'],
      emailUpdates: json['emailUpdates'],
    );
  }
}
