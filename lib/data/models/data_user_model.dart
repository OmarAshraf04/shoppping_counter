class DataUserModel {
  String email;
  String name;
  String password;
  String uid;
  String image;

  DataUserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.image});

  factory DataUserModel.fromJson(Map<String, dynamic> json) {
    return DataUserModel(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        uid: json['uid'],
        image: json['image']);
  }
}
