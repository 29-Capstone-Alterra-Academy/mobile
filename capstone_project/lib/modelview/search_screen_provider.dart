// import package
import 'package:capstone_project/model/search_user_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:flutter/material.dart';

// import utils
import 'package:capstone_project/utils/finite_state.dart';

// import service
import 'package:capstone_project/services/api_services.dart';

// import model
// import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/category_model.dart';

class SearchScreenProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;
  FiniteState categoryState = FiniteState.none;
  FiniteState userState = FiniteState.none;

  List<CategoryModel> popularCategory = [];
  List<CategoryModel> allCategory = [];
  List<SearchUserModel> popularUser = [];

  List<ThreadModel> searchThread = [];
  List<CategoryModel> searchCategory = [];
  List<SearchUserModel> searchUser = [];

  void changeCategoryState(FiniteState s) {
    categoryState = s;
    notifyListeners();
  }

  void changeUserState(FiniteState s) {
    userState = s;
    notifyListeners();
  }

  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// GET 3 POPULAR TOPICS
  void getPopularCategory() async {
    changeCategoryState(FiniteState.loading);
    popularCategory = await _apiServices.getCategory(limit: 3);
    changeCategoryState(FiniteState.none);
  }

  /// GET MOST POPULAR TOPICS
  void getAllPopularCategory(int limit) async {
    changeCategoryState(FiniteState.loading);
    allCategory = await _apiServices.getCategory(limit: limit);
    changeCategoryState(FiniteState.none);
  }

  /// GET MOST POPULAR USER
  void getPopularUser() async {
    changeUserState(FiniteState.loading);
    // popularUser = await _apiServices.getUsers();
    popularUser = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: 'user', scope: 'user');
    popularUser.sort((a, b) => a.followersCount!.compareTo(b.followersCount!));
    popularUser = popularUser.reversed.toList();
    changeUserState(FiniteState.none);
  }

  void getSearchResult(String keyword) async {
    changeState(FiniteState.loading);
    searchThread = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: keyword, scope: 'thread');
    searchCategory = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: keyword, scope: 'topic');
    searchUser = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: keyword, scope: 'user');
    changeState(FiniteState.none);
  }
}
