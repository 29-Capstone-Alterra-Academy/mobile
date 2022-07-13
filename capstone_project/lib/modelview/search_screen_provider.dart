// import package
import 'package:flutter/material.dart';

// import utils
import 'package:capstone_project/utils/finite_state.dart';

// import service
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/search_model.dart';
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/category_model.dart';

class SearchScreenProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;

  List<CategoryModel> popularCategory = [];
  List<CategoryModel> allCategory = [];
  List<UserModel> popularUser = [];
  SearchModel searchResult = SearchModel();

  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// GET 3 POPULAR TOPICS
  void getPopularCategory() async {
    changeState(FiniteState.loading);
    popularCategory = await _apiServices.getCategory(limit: 3);
    changeState(FiniteState.none);
  }

  /// GET MOST POPULAR TOPICS
  void getAllPopularCategory(int limit) async {
    changeState(FiniteState.loading);
    allCategory = await _apiServices.getCategory(limit: limit);
    changeState(FiniteState.none);
  }

  /// GET MOST POPULAR USER
  void getPopularUser() async {
    changeState(FiniteState.loading);
    popularUser = await _apiServices.getUsers();
    changeState(FiniteState.none);
  }

  void getSearchResult(String keywoard) async {
    changeState(FiniteState.loading);
    searchResult = await _apiServices.getSearchResult();
    changeState(FiniteState.none);
  }
}
