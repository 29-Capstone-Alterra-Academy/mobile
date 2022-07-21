class ReplyModel {
  int? id;
  Author? author;
  String? content;
  String? image;
  int? likedCount;
  int? unlikedCount;
  int? replyCount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ReplyModel(
      {this.id,
      this.author,
      this.content,
      this.image,
      this.likedCount,
      this.unlikedCount,
      this.replyCount,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author =
        json['author'] != null ? Author.fromJson(json['author']) : null;
    content = json['content'];
    image = json['image'];
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
    data['content'] = content;
    data['image'] = image;
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
  String? profileImage;
  String? deletedAt;

  Author({this.id, this.username, this.profileImage, this.deletedAt});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileImage = json['profile_image'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['profile_image'] = profileImage;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
