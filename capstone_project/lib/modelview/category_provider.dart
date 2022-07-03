import 'package:flutter/cupertino.dart';

import 'package:capstone_project/utils/finite_state.dart';

import 'package:capstone_project/services/api_services.dart';

import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/search_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/category_model.dart';
import 'package:capstone_project/model/moderator_model.dart';

class CategoryProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;
  FiniteState subState = FiniteState.none;

  List<CategoryModel> category = [];
  List<ModeratorModel> moderators = [];
  List<ThreadModel> threads = [];
  SearchModel? results;

  CategoryModel currentCategory = CategoryModel();
  UserModel selectedModerator = UserModel();

  int currentPage = 0;

  bool isSub = false;
  bool isSearched = false;

  void changeSub(bool sub) {
    isSub = sub;
    notifyListeners();
  }

  // CHANGE MAIN STATE
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  // CHANGE THREAD SECTION STATE
  void changeSubState(FiniteState s) {
    subState = s;
    notifyListeners();
  }

  // CHANGE TAB FOR POPULAR || NEWEST THREAD
  void changePage(int index, String categoryName) {
    currentPage = index;
    if (index == 0) {
      getPopularThread(categoryName);
    } else if (index == 1) {
      getNewestThread(categoryName);
    }
    notifyListeners();
  }

  /// Get All Category
  void getCategory() async {
    changeState(FiniteState.loading);
    category = await _apiServices.getCategroy();
    changeState(FiniteState.none);
  }

  /// Get Category By ID
  void getCategoryById(int idCategory) async {
    changeState(FiniteState.loading);
    currentCategory = await _apiServices.getCategroyById(idCategory);
    changeState(FiniteState.none);
    notifyListeners();
  }

  /// Get Moderator On This Category
  void getModerator() async {
    changeState(FiniteState.loading);
    moderators = await _apiServices.getModerator(currentCategory.id ?? 9);
    changeState(FiniteState.none);
  }

  /// Get Popular Thread From This Category
  void getPopularThread(String categoryName) async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(
        categoryName: categoryName, sortby: 'like');
    changeSubState(FiniteState.none);
  }

  /// Get Newest Thread From This Category
  void getNewestThread(String categoryName) async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(
        categoryName: categoryName, sortby: 'date');
    changeSubState(FiniteState.none);
  }

  /// SUBSCRIBE TO CATEGORY
  Future subscribeCategory(int idCategory) async {
    if (await _apiServices.subscribeCategory(idCategory)) {
      changeSub(true);
    }
  }

  /// UNSUBSCRIBE TO CATEGORY
  Future unsubscribeCategory(int idCategory) async {
    if (await _apiServices.subscribeCategory(idCategory)) {
      changeSub(false);
    }
  }

  /// Report Category
  Future<String> reportCategory(
      CategoryModel categoryModel, String reason) async {
    if (await _apiServices.reportCategory(categoryModel, reason)) {
      return "Laporan Anda sudah dikirim. Terima kasih.";
    }
    return "Laporan Anda gagal dikirim";
  }

  /// Request Moderator
  Future<String> requestModerator(CategoryModel categoryModel) async {
    if (await _apiServices.requestModerator(categoryModel)) {
      return "Pengajuan Anda menjadi moderator terkirim";
    }
    return "Pengajuan Anda menjadi moderator gagal terkirim";
  }

  /// Search  On Category
  void getSearchResult({String? category}) async {
    changeState(FiniteState.loading);
    results = await _apiServices.getSearchResult(category: category);
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
