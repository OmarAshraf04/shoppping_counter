class DataUserModel {

  final String email;
  final String name;
  final String password;
  final String uid;


  DataUserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid
});

  factory DataUserModel.fromJson(Map<String, dynamic> json) {
    return DataUserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      uid: json['id']
    );
  }
}
