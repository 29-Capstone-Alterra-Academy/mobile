class ThreadModel {
  Author? author;
  String? content;
  String? createdAt;
  int? id;
  List<String>? images;
  String? title;
  Topic? topic;
  String? updatedAt;

  ThreadModel(
      {this.author,
      this.content,
      this.createdAt,
      this.id,
      this.images,
      this.title,
      this.topic,
      this.updatedAt});

  ThreadModel.fromJson(Map<String, dynamic> json) {
    author =
        json['author'] != null ? Author.fromJson(json['author']) : null;
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    images = json['images'].cast<String>();
    title = json['title'];
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['content'] = content;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['images'] = images;
    data['title'] = title;
    if (topic != null) {
      data['topic'] = topic!.toJson();
    }
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Author {
  int? id;
  String? profileImage;
  String? username;

  Author({this.id, this.profileImage, this.username});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_image'] = profileImage;
    data['username'] = username;
    return data;
  }
}

class Topic {
  int? activityCount;
  int? contributorCount;
  String? description;
  int? id;
  int? moderatorCount;
  String? name;
  String? profileImage;
  String? rules;

  Topic(
      {this.activityCount,
      this.contributorCount,
      this.description,
      this.id,
      this.moderatorCount,
      this.name,
      this.profileImage,
      this.rules});

  Topic.fromJson(Map<String, dynamic> json) {
    activityCount = json['activity_count'];
    contributorCount = json['contributor_count'];
    description = json['description'];
    id = json['id'];
    moderatorCount = json['moderator_count'];
    name = json['name'];
    profileImage = json['profile_image'];
    rules = json['rules'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_count'] = activityCount;
    data['contributor_count'] = contributorCount;
    data['description'] = description;
    data['id'] = id;
    data['moderator_count'] = moderatorCount;
    data['name'] = name;
    data['profile_image'] = profileImage;
    data['rules'] = rules;
    return data;
  }
}
