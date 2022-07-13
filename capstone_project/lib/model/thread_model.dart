class ThreadModel {
  int? id;
  Author? author;
  Topic? topic;
  String? title;
  String? content;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  int? likedCount;
  int? unlikedCount;
  int? replyCount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ThreadModel(
      {this.id,
      this.author,
      this.topic,
      this.title,
      this.content,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.likedCount,
      this.unlikedCount,
      this.replyCount,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ThreadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author =
        json['author'] != null ? Author.fromJson(json['author']) : null;
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    title = json['title'];
    content = json['content'];
    image1 = json['image_1'];
    image2 = json['image_2'];
    image3 = json['image_3'];
    image4 = json['image_4'];
    image5 = json['image_5'];
    likedCount = json['liked_count'];
    unlikedCount = json['unliked_count'];
    replyCount = json['reply_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (topic != null) {
      data['topic'] = topic!.toJson();
    }
    data['title'] = title;
    data['content'] = content;
    data['image_1'] = image1;
    data['image_2'] = image2;
    data['image_3'] = image3;
    data['image_4'] = image4;
    data['image_5'] = image5;
    data['liked_count'] = likedCount;
    data['unliked_count'] = unlikedCount;
    data['reply_count'] = replyCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Author {
  int? id;
  String? username;
  String? deletedAt;

  Author({this.id, this.username, this.deletedAt});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Topic {
  int? id;
  String? name;
  String? profileImage;

  Topic({this.id, this.name, this.profileImage});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_image'] = profileImage;
    return data;
  }
}
