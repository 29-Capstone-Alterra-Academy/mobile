// import package
import 'package:capstone_project/model/moderator_model/moderator_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import utils
import 'package:capstone_project/utils/finite_state.dart';

// import services
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/model/moderator_model/modrequest_model.dart';

class AdminModeratorProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  List<CategoryModel> categories = [];
  List<ModrequestModel> modrequest = [];
  List<ModeratorModel> moderators = [];
  List<CategoryModel> results = [];

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

  /// Reject Moderator Request
  Future rejectModrequest(int promotionId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      await _apiServices.actionModrequest(
        token: token,
        promotionId: promotionId,
        action: 'reject',
      );
    }
  }

  /// Approve Moderator Request
  Future acceptModrequest(int promotionId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      await _apiServices.actionModrequest(
        token: token,
        promotionId: promotionId,
        action: 'approve',
      );
    }
  }

  /// Get Moderator by Category Id
  void getModerator(int categoryId) async {
    changeState(FiniteState.loading);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      moderators = await _apiServices.getModerator(
        idCategory: categoryId,
        token: token,
      );
    }
    changeState(FiniteState.none);
  }

  /// Get Moderator Request
  void getModrequest() async {
    changeState(FiniteState.loading);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      modrequest = await _apiServices.getModrequest(token);
      modrequest.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      modrequest = modrequest.reversed.toList();
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
  void getSearchResult(String keyword) async {
    results.clear();
    for (var element in categories) {
      if (element.name!.contains(keyword) ||
          element.name!.contains(keyword.characters.first.toUpperCase())) {
        results.add(element);
      }
    }
    isSearched = true;
    notifyListeners();
  }

  /// Reset search result
  void resetSearchResult() {
    isSearched = false;
    results.clear();
    notifyListeners();
  }
}
