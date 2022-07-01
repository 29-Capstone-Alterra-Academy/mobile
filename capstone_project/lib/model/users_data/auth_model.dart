//import '../api/auth_api.dart';

class Authentication {
  String? email;
  String? password;

  Authentication({this.email, this.password});

  // Authentication.fromJson(Map<String, dynamic> json) {
  //   email = json['email'];
  //   password = json['password'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['email'] = email;
  //   data['password'] = password;
  //   return data;
  // }
}
