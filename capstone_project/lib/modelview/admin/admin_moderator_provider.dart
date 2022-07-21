// import package

import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/model/search_model/search_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:flutter/cupertino.dart';

// import package
import 'package:capstone_project/utils/finite_state.dart';

// import services
// import 'package:capstone_project/services/api_services.dart';

// import model
// import 'package:capstone_project/model/thread_model.dart';

class AdminModeratorProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  List<CategoryModel> categories = [];
  SearchModel? results;

  FiniteState state = FiniteState.none;
  int currentPage = 0;
  bool isSearched = false;

  /// Change tab page
  void changePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// Get Moderator Request

  /// Get Category for Active Moderator
  void getSearchResult({required String category}) async {
    changeState(FiniteState.loading);
    results = await _apiServices.getSearchResult(
      limit: 30,
      offset: 0,
      keyword: category,
      scope: 'topic',
    );
    isSearched = true;
    changeState(FiniteState.none);
  }

  /// Reset search result
  void resetSearchResult() {
    isSearched = false;
    results = null;
    notifyListeners();
  }
}
