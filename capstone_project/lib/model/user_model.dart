class UserModel {
  String? birthDate;
  String? email;
  String? gender;
  int? id;
  String? profileImage;
  String? username;

  UserModel({
    this.birthDate,
    this.email,
    this.gender,
    this.id,
    this.profileImage,
    this.username,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    birthDate = json['birth_date'];
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    profileImage = json['profile_image'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birth_date'] = birthDate;
    data['email'] = email;
    data['gender'] = gender;
    data['id'] = id;
    data['profile_image'] = profileImage;
    data['username'] = username;
    return data;
  }
}
