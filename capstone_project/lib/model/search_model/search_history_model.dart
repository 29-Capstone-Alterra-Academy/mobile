class SearchHistoryModel {
  int? id;
  String? keyword;

  SearchHistoryModel({
    this.id,
    this.keyword
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'keyword': keyword,
    };
  }

  SearchHistoryModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    keyword = map['keyword'];
  }
}
