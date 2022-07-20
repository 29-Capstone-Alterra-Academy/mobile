// import package
import 'package:capstone_project/model/moderator_model/modrequest_model.dart';
import 'package:capstone_project/model/search_model/search_model.dart';
// import 'package:capstone_project/services/api_services.dart';
import 'package:flutter/cupertino.dart';

// import package
import 'package:capstone_project/utils/finite_state.dart';

// import services
import 'package:capstone_project/services/api_services.dart';

// import model
// import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminModeratorProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  List<CategoryModel> categories = [];
  List<ModrequestModel> modrequest = [];
  SearchModel? results;

  FiniteState state = FiniteState.none;
  int currentPage = 0;
  bool isSearched = false;

  /// Change tab page
  void changePage(int index) {
    if (index == 0) {
      getCategories();
    } else if (index == 1) {
      getModrequest();
    }
    currentPage = index;
    notifyListeners();
  }

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// Get Moderator Request
  void getModrequest() async {
    changeState(FiniteState.loading);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      modrequest = await _apiServices.getModrequest(token);
    }
    changeState(FiniteState.none);
  }

  /// Get Categories
  void getCategories() async {
    changeState(FiniteState.loading);
    categories = await _apiServices.getCategory(limit: 30);
    categories.sort((a, b) => a.name!.compareTo(b.name!));
    changeState(FiniteState.none);
  }

  /// Get Category for Active Moderator
  void getSearchResult({String? category}) async {
    changeState(FiniteState.loading);
    // results = await _apiServices.getSearchResult(category: category);
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
