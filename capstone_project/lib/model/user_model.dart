class UserModel {
  int? id;
  String? username;
  String? email;
  String? gender;
  String? profileImage;
  bool? isVerified;
  String? birthDate;
  String? bio;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.gender,
      this.profileImage,
      this.isVerified,
      this.birthDate,
      this.bio,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    isVerified = json['is_verified'];
    birthDate = json['birth_date'];
    bio = json['bio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['gender'] = gender;
    data['profile_image'] = profileImage;
    data['is_verified'] = isVerified;
    data['birth_date'] = birthDate;
    data['bio'] = bio;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
