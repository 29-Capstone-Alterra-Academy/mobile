class ReportUserModel {
  Reporter? reporter;
  Reason? reason;
  Suspect? suspect;
  String? createdAt;

  ReportUserModel({this.reporter, this.reason, this.suspect, this.createdAt});

  ReportUserModel.fromJson(Map<String, dynamic> json) {
    reporter = json['reporter'] != null
        ? Reporter.fromJson(json['reporter'])
        : null;
    reason =
        json['reason'] != null ? Reason.fromJson(json['reason']) : null;
    suspect =
        json['suspect'] != null ? Suspect.fromJson(json['suspect']) : null;
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
    if (suspect != null) {
      data['suspect'] = suspect!.toJson();
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

class Suspect {
  int? id;
  String? username;
  String? profileImage;

  Suspect({this.id, this.username, this.profileImage});

  Suspect.fromJson(Map<String, dynamic> json) {
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
