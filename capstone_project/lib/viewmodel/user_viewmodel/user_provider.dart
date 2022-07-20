// import package
import 'package:flutter/cupertino.dart';

// import utils
import 'package:capstone_project/utils/finite_state.dart';

// import service
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/thread_model/thread_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:capstone_project/model/user_model/user_model.dart';
import 'package:capstone_project/model/moderator_model/moderator_model.dart';

class UserProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;
  FiniteState subState = FiniteState.none;

  List<UserModel> users = [];
  List<ModeratorModel> moderators = [];
  List<ThreadModel> threads = [];
  List<ThreadModel> results = [];

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
  void changePage(int index, int idUser) {
    currentPage = index;
    if (index == 0) {
      getPopularThread(idUser);
    } else if (index == 1) {
      getNewestThread(idUser);
    }
    notifyListeners();
  }

  // reset tab page
  void resetPage() {
    currentPage = 0;
    isSub = false;
    notifyListeners();
  }

  /// Get User By ID
  void getDetailUser(int idUser) async {
    changeState(FiniteState.loading);
    selectedUser = await _apiServices.getUsersById(idUser);
    threads = await _apiServices.getThread(userId: idUser);
    // sort by reply count
    threads.sort(
      (a, b) => a.replyCount!.compareTo(b.replyCount!),
    );
    // reverse list
    threads = threads.reversed.toList();
    changeState(FiniteState.none);
  }

  /// Get Popular Thread From This User
  void getPopularThread(int idUser) async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(userId: idUser);
    // sort by reply count
    threads.sort(
      (a, b) => a.replyCount!.compareTo(b.replyCount!),
    );
    // reverse list
    threads = threads.reversed.toList();
    changeSubState(FiniteState.none);
  }

  /// Get Newest Thread From This User
  void getNewestThread(int idUser) async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(userId: idUser);
    // sort by id
    threads.sort(
      (a, b) => a.id!.compareTo(b.id!),
    );
    // reverse list
    threads = threads.reversed.toList();
    changeSubState(FiniteState.none);
  }

  /// Follow User
  Future followUser(int idUser) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.followUser(token: token, idUser: idUser)) {
        getDetailUser(idUser);
        changeSub(true);
      }
    }
  }

  /// Unfollow User
  Future unfollowUser(int idUser) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.unfollowUser(token: token, idUser: idUser)) {
        getDetailUser(idUser);
        changeSub(false);
      }
    }
  }

  /// Report User
  Future<String> reportUser(UserModel targetUser, int reasonId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.reportUser(token, targetUser, reasonId)) {
        return "Laporan Anda sudah dikirim. Terima kasih.";
      }
    }
    return "Laporan Anda gagal dikirim";
  }

  /// Search  On User
  void getSearchResult(String keyword) async {
    changeState(FiniteState.loading);
    results = await _apiServices.getSearchResult(
        limit: 100, offset: 0, keyword: keyword, scope: 'thread');
    isSearched = true;
    changeState(FiniteState.none);
  }

  /// Reset search result
  void resetSearchResult() {
    isSearched = false;
    results.clear();
    notifyListeners();
  }
}
