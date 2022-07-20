// ignore_for_file: unnecessary_new

class UserModel {
  int? iD;
  String? username;
  String? profileImage;
  String? bio;
  int? threadCount;
  int? followingCount;
  int? followersCount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserModel(
      {this.iD,
      this.username,
      this.profileImage,
      this.bio,
      this.threadCount,
      this.followingCount,
      this.followersCount,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    username = json['Username'];
    profileImage = json['ProfileImage'];
    bio = json['Bio'];
    threadCount = json['ThreadCount'];
    followingCount = json['FollowingCount'];
    followersCount = json['FollowersCount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Username'] = username;
    data['ProfileImage'] = profileImage;
    data['Bio'] = bio;
    data['ThreadCount'] = threadCount;
    data['FollowingCount'] = followingCount;
    data['FollowersCount'] = followersCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
