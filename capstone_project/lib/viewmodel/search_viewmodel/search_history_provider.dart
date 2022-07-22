import 'package:flutter/cupertino.dart';
import 'package:capstone_project/services/database_helper.dart';
import 'package:capstone_project/model/search_model/search_history_model.dart';

class SearchHistoryProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<SearchHistoryModel> history = [];
  List<SearchHistoryModel> result = [];
  bool isSearched = false;

  void searchHistory(String keyword) {
    result.clear();
    for (var element in history) {
      if (element.keyword!.contains(keyword)) {
        result.add(element);
      }
    }
    isSearched = true;
    notifyListeners();
  }

  void getHistory() async {
    history.clear();
    history = await _databaseHelper.getHistory();
    notifyListeners();
  }

  Future checkHistory(String keyword) async {
    bool isSaved = true;
    for (var element in history) {
      if (element.keyword == keyword) {
        return false;
      }
    }
    if (isSaved) {
      await addHistory(keyword);
    }
  }

  Future addHistory(String keyword) async {
    await _databaseHelper.insertHistory(SearchHistoryModel(keyword: keyword));
    notifyListeners();
  }

  void removeHistory(int id) async {
    await _databaseHelper.deleteHistory(id);
    getHistory();
  }

  void resetSearch() {
    result.clear();
    isSearched = false;
    notifyListeners();
  }
}
