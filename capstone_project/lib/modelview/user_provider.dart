// import package
import 'package:flutter/cupertino.dart';

// import utils
import 'package:capstone_project/utils/finite_state.dart';

// import service
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/search_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/moderator_model.dart';

class UserProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;
  FiniteState subState = FiniteState.none;

  List<UserModel> users = [];
  List<ModeratorModel> moderators = [];
  List<ThreadModel> threads = [];
  SearchModel? results;

  UserModel? selectedUser;

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

  /// Get User By ID
  void getDetailUser(int idUser) async {
    changeState(FiniteState.loading);
    selectedUser = await _apiServices.getUsersById(idUser);
    threads = await _apiServices.getThread(
      username: selectedUser!.username,
      sortby: 'like',
    );
    changeState(FiniteState.none);
  }

  /// Get Popular Thread From This User
  void getPopularThread(String username) async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(username: username, sortby: 'like');
    changeSubState(FiniteState.none);
  }

  /// Get Newest Thread From This User
  void getNewestThread(String username) async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(username: username, sortby: 'date');
    changeSubState(FiniteState.none);
  }

  /// Follow User
  Future followUser(int idUser) async {
    if (await _apiServices.followUser(idUser)) {
      changeSub(true);
    }
  }

  /// Unfollow User
  Future unfollowUser(int idUser) async {
    if (await _apiServices.unfollowUser(idUser)) {
      changeSub(false);
    }
  }

  /// Report User
  Future<String> reportUser(
      UserModel currentUser, UserModel targetUser, String reason) async {
    if (await _apiServices.reportUser(currentUser, targetUser, reason)) {
      return "Laporan Anda sudah dikirim. Terima kasih.";
    }
    return "Laporan Anda gagal dikirim";
  }

  /// Search  On User
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
