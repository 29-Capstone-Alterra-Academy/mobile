// import package
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import utils
import 'package:capstone_project/utils/finite_state.dart';

// import service
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/thread_model/thread_model.dart';
import 'package:capstone_project/model/user_model/user_model.dart';
import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/model/search_model/search_user_model.dart';
import 'package:capstone_project/model/moderator_model/moderator_model.dart';
import 'package:capstone_project/model/search_model/search_category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;
  FiniteState subState = FiniteState.none;

  List<CategoryModel> category = [];
  List<ModeratorModel> moderators = [];
  List<ThreadModel> threads = [];

  List<ThreadModel> searchThread = [];
  List<SearchCategoryModel> searchCategory = [];
  List<SearchUserModel> searchUser = [];

  CategoryModel currentCategory = CategoryModel();
  UserModel selectedModerator = UserModel();

  int currentPage = 0;

  bool isSub = false;
  bool isSearched = false;

  void changeSub(bool sub) {
    isSub = sub;
    notifyListeners();
  }

  void resetPage() {
    currentPage = 0;
    isSub = false;
    currentCategory = CategoryModel();
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
  void changePage(int index, int categoryId) {
    currentPage = index;
    if (index == 0) {
      getPopularThread(categoryId);
    } else if (index == 1) {
      getNewestThread(categoryId);
    }
    notifyListeners();
  }

  /// Get All Category
  void getCategory() async {
    changeState(FiniteState.loading);
    category = await _apiServices.getCategory();
    changeState(FiniteState.none);
  }

  /// Get Category By ID
  void getDetailCategory(int idCategory) async {
    changeState(FiniteState.loading);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    currentCategory = await _apiServices.getCategroyById(
      token: token ?? '',
      idCategory: idCategory,
    );
    getPopularThread(idCategory);
    changeState(FiniteState.none);
  }

  /// Get Moderator On This Category
  void getModerator() async {
    changeState(FiniteState.loading);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      moderators = await _apiServices.getModerator(
        token: token,
        idCategory: currentCategory.id!,
      );
    }
    changeState(FiniteState.none);
  }

  /// Get Popular Thread From This Category
  void getPopularThread(int categoryId) async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(categoryId: categoryId);
    // sort by reply count
    threads.sort(
      (a, b) => a.replyCount!.compareTo(b.replyCount!),
    );
    // reverse list
    threads = threads.reversed.toList();
    changeSubState(FiniteState.none);
  }

  /// Get Newest Thread From This Category
  void getNewestThread(int categoryId) async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(categoryId: categoryId);
    // sort by id
    threads.sort(
      (a, b) => a.id!.compareTo(b.id!),
    );
    // reverse list
    threads = threads.reversed.toList();
    changeSubState(FiniteState.none);
  }

  /// SUBSCRIBE TO CATEGORY
  Future subscribeCategory(int idCategory) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.subscribeCategory(
        token: token,
        idCategory: idCategory,
      )) {
        changeSub(true);
      }
    }
  }

  /// UNSUBSCRIBE TO CATEGORY
  Future unsubscribeCategory(int idCategory) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.unsubscribeCategory(
        token: token,
        idCategory: idCategory,
      )) {
        changeSub(false);
      }
    }
  }

  /// Report Category
  Future<String> reportCategory(
      CategoryModel categoryModel, int reasonId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.reportCategory(token, categoryModel, reasonId)) {
        return "Laporan Anda sudah dikirim. Terima kasih.";
      }
    }
    return "Laporan Anda gagal dikirim";
  }

  /// Request Moderator
  Future<String> requestModerator(CategoryModel categoryModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.requestModerator(
        token: token,
        idCategory: categoryModel.id!,
      )) {
        return "Pengajuan Anda menjadi moderator terkirim";
      }
    }
    return "Pengajuan Anda menjadi moderator gagal terkirim";
  }

  /// Search  On Category
  void getSearchResult({required String keyword}) async {
    changeState(FiniteState.loading);
    searchThread = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: keyword, scope: 'thread');
    searchCategory = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: keyword, scope: 'topic');
    searchUser = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: keyword, scope: 'user');
    isSearched = true;
    changeState(FiniteState.none);
  }

  /// Reset search result
  void resetSearchResult() {
    isSearched = false;
    searchThread = [];
    searchCategory = [];
    searchUser = [];
    notifyListeners();
  }
}
