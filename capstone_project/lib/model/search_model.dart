// import model
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/category_model.dart';

class SearchModel {
  List<ThreadModel>? threads;
  List<CategoryModel>? topics;
  List<UserModel>? users;

  SearchModel({this.threads, this.topics, this.users});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['threads'] != null) {
      threads = <ThreadModel>[];
      json['threads'].forEach((v) {
        threads!.add(ThreadModel.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = <CategoryModel>[];
      json['topics'].forEach((v) {
        topics!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (threads != null) {
      data['threads'] = threads!.map((v) => v.toJson()).toList();
    }
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Threads {
  Author? author;
  String? content;
  String? createdAt;
  List<String>? images;
  String? title;
  Topic? topic;
  String? updatedAt;

  Threads(
      {this.author,
      this.content,
      this.createdAt,
      this.images,
      this.title,
      this.topic,
      this.updatedAt});

  Threads.fromJson(Map<String, dynamic> json) {
    author =
        json['author'] != null ? Author.fromJson(json['author']) : null;
    content = json['content'];
    createdAt = json['created_at'];
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
  String? profileImage;
  String? username;

  Author({this.profileImage, this.username});

  Author.fromJson(Map<String, dynamic> json) {
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

class Topic {
  String? description;
  String? name;
  String? profileImage;
  String? rules;

  Topic({this.description, this.name, this.profileImage, this.rules});

  Topic.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    profileImage = json['profile_image'];
    rules = json['rules'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['name'] = name;
    data['profile_image'] = profileImage;
    data['rules'] = rules;
    return data;
  }
}
