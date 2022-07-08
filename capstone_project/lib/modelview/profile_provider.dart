import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;
  FiniteState subState = FiniteState.none;

  List<ThreadModel> threads = [];

  UserModel? currentUser;

  int currentPage = 0;

  bool isSub = false;

  // CHANGE MAIN STATE
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// GET CURRENT USER PROFILE
  void getProfile() async {
    changeState(FiniteState.loading);
    currentUser = await _apiServices.getUserProfile();
    changeState(FiniteState.none);
  }

  // CHANGE THREAD SECTION STATE
  void changeSubState(FiniteState s) {
    subState = s;
    notifyListeners();
  }

  // CHANGE TAB FOR POPULAR || NEWEST THREAD
  void changePage(int index) {
    currentPage = index;
    if (index == 0) {
      getPopularThread();
    } else if (index == 1) {
      getNewestThread();
    }
    notifyListeners();
  }

  /// Get Popular Thread From This User
  void getPopularThread() async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(
      username: currentUser!.username,
      sortby: 'like',
    );
    changeSubState(FiniteState.none);
  }

  /// Get Newest Thread From This User
  void getNewestThread() async {
    changeSubState(FiniteState.loading);
    threads = await _apiServices.getThread(
      username: currentUser!.username,
      sortby: 'date',
    );
    changeSubState(FiniteState.none);
  }
}
