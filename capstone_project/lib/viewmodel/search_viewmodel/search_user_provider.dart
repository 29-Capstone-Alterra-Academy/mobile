import 'package:capstone_project/model/search_model/search_user_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/cupertino.dart';

class SearchUserProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;

  List<SearchUserModel> searchUser = [];
  bool isSearched = false;

  // CHANGE MAIN STATE
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// Search  On Category
  void getSearchResult({required String keyword}) async {
    changeState(FiniteState.loading);
    searchUser = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: keyword, scope: 'user');
    isSearched = true;
    changeState(FiniteState.none);
  }

  /// Reset search result
  void resetSearchResult() {
    isSearched = false;
    searchUser = [];
    notifyListeners();
  }
}
