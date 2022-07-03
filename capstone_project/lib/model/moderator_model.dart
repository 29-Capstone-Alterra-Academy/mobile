class ModeratorModel {
  String? profileImage;
  String? username;

  ModeratorModel({this.profileImage, this.username});

  ModeratorModel.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_image'] = profileImage;
    data['username'] = username;
    return data;
  }
}
