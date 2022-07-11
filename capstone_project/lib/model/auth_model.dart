class AuthenticationModel {
  String? email;
  String? username;
  String? password;

  AuthenticationModel({this.email, this.username, this.password});

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
