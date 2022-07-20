class SearchUserModel {
  int? id;
  String? username;
  String? profileImage;
  int? followersCount;

  SearchUserModel(
      {this.id, this.username, this.profileImage, this.followersCount});

  SearchUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileImage = json['profile_image'];
    followersCount = json['followers_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['profile_image'] = profileImage;
    data['followers_count'] = followersCount;
    return data;
  }
}
