class ReportReplyModel {
  Reporter? reporter;
  Reason? reason;
  Topic? topic;
  Reply? reply;
  String? createdAt;

  ReportReplyModel(
      {this.reporter, this.reason, this.topic, this.reply, this.createdAt});

  ReportReplyModel.fromJson(Map<String, dynamic> json) {
    reporter = json['reporter'] != null
        ? Reporter.fromJson(json['reporter'])
        : null;
    reason =
        json['reason'] != null ? Reason.fromJson(json['reason']) : null;
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    reply = json['reply'] != null ? Reply.fromJson(json['reply']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reporter != null) {
      data['reporter'] = reporter!.toJson();
    }
    if (reason != null) {
      data['reason'] = reason!.toJson();
    }
    if (topic != null) {
      data['topic'] = topic!.toJson();
    }
    if (reply != null) {
      data['reply'] = reply!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Reporter {
  int? id;
  String? username;
  String? profileImage;

  Reporter({this.id, this.username, this.profileImage});

  Reporter.fromJson(Map<String, dynamic> json) {
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

class Reason {
  int? id;
  String? detail;

  Reason({this.id, this.detail});

  Reason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['detail'] = detail;
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

class Reply {
  int? id;
  String? content;
  String? image;

  Reply({this.id, this.content, this.image});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['image'] = image;
    return data;
  }
}
