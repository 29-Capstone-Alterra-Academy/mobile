class ModeratorModel {
  int? id;
  String? username;
  String? profileImage;

  ModeratorModel({this.id, this.username, this.profileImage});

  ModeratorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['profile_image'] = profileImage;
    return data;
  }
}
