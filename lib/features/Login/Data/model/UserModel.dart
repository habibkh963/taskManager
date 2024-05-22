import '../../Domain/entites/User.dart';

class UserModel extends User {
  UserModel(
      {super.id,
      super.username,
      super.email,
      super.firstName,
      super.lastName,
      super.gender,
      super.image,
      super.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = super.id;
    data['username'] = super.username;
    data['email'] = super.email;
    data['firstName'] = super.firstName;
    data['lastName'] = super.lastName;
    data['gender'] = super.gender;
    data['image'] = super.image;
    data['token'] = super.token;
    return data;
  }
}
