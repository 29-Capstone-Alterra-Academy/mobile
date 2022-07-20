class SearchCategoryModel {
  int? id;
  String? name;
  String? profileImage;
  int? threadCount;

  SearchCategoryModel(
      {this.id, this.name, this.profileImage, this.threadCount});

  SearchCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    threadCount = json['thread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_image'] = profileImage;
    data['thread_count'] = threadCount;
    return data;
  }
}
