class CategoryModel {
  int? id;
  String? name;
  String? profileImage;
  String? description;
  String? rules;
  int? activityCount;
  int? contributorCount;
  int? moderatorCount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CategoryModel(
      {this.id,
      this.name,
      this.profileImage,
      this.description,
      this.rules,
      this.activityCount,
      this.contributorCount,
      this.moderatorCount,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    description = json['description'];
    rules = json['rules'];
    activityCount = json['activity_count'];
    contributorCount = json['contributor_count'];
    moderatorCount = json['moderator_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_image'] = profileImage;
    data['description'] = description;
    data['rules'] = rules;
    data['activity_count'] = activityCount;
    data['contributor_count'] = contributorCount;
    data['moderator_count'] = moderatorCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
