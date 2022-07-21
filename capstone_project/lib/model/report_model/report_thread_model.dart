class ReportThreadModel {
  Reporter? reporter;
  Reason? reason;
  Topic? topic;
  Thread? thread;
  String? createdAt;

  ReportThreadModel(
      {this.reporter, this.reason, this.topic, this.thread, this.createdAt});

  ReportThreadModel.fromJson(Map<String, dynamic> json) {
    reporter = json['reporter'] != null
        ? Reporter.fromJson(json['reporter'])
        : null;
    reason =
        json['reason'] != null ? Reason.fromJson(json['reason']) : null;
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    thread =
        json['thread'] != null ? Thread.fromJson(json['thread']) : null;
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
    if (thread != null) {
      data['thread'] = thread!.toJson();
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

class Thread {
  int? id;
  String? title;
  String? content;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;

  Thread(
      {this.id,
      this.title,
      this.content,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5});

  Thread.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image1 = json['image_1'];
    image2 = json['image_2'];
    image3 = json['image_3'];
    image4 = json['image_4'];
    image5 = json['image_5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['image_1'] = image1;
    data['image_2'] = image2;
    data['image_3'] = image3;
    data['image_4'] = image4;
    data['image_5'] = image5;
    return data;
  }
}
