class CategoryModel {
  int? activityCount;
  int? contributorCount;
  String? description;
  int? moderatorCount;
  String? name;
  String? profileImage;
  String? rules;

  CategoryModel(
      {this.activityCount,
      this.contributorCount,
      this.description,
      this.moderatorCount,
      this.name,
      this.profileImage,
      this.rules});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    activityCount = json['activity_count'];
    contributorCount = json['contributor_count'];
    description = json['description'];
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
    data['moderator_count'] = moderatorCount;
    data['name'] = name;
    data['profile_image'] = profileImage;
    data['rules'] = rules;
    return data;
  }
}
