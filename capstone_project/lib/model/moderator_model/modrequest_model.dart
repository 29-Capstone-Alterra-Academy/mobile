class ModrequestModel {
  int? id;
  User? user;
  Topic? topic;
  String? createdAt;

  ModrequestModel({this.id, this.user, this.topic, this.createdAt});

  ModrequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (topic != null) {
      data['topic'] = topic!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? profileImage;

  User({this.id, this.username, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
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

class Topic {
  int? id;
  String? name;

  Topic({this.id, this.name});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
